from fastapi import FastAPI, File, UploadFile
import requests
import uvicorn
import os
import numpy as np
import cv2
from collections import defaultdict
import urllib.request


async def detect_object(img):
    # load Yolo
    if os.path.exists("models/yolov3.weights"):
        yolo_weight = "models/yolov3.weights"
    else:
        print("Downloading Model File......")
        URL = "https://pjreddie.com/media/files/yolov3.weights"
        yolo_weight = urllib.request.urlretrieve(URL, filename="models/yolov3.weights")
        print("Model download complete")

    yolo_config = "models/yolov3.cfg"
    coco_names = "models/coco.names"
    net = cv2.dnn.readNet(model=yolo_weight, config=yolo_config)

    classes = []
    with open(coco_names, "r") as f:
        classes = [line.strip() for line in f.readlines()]
    # print(classes)

    height0, width0, channels0 = img.shape
    img_copy0 = img
    # define the desired shape
    fWidth = 320
    fHeight = 320

    # resie image
    img = cv2.resize(img, (fWidth, fHeight))
    height, width, channels = img.shape
    # print(img.shape)
    # convert image to blob
    blob = cv2.dnn.blobFromImage(
        img, 1 / 255, (fWidth, fHeight), (0, 0, 0), True, crop=False
    )
    net.setInput(blob)

    layer_names = net.getLayerNames()
    # print(layer_names)
    output_layers = [layer_names[i - 1] for i in net.getUnconnectedOutLayers()]
    # print(output_layers)

    outs = net.forward(output_layers)
    # print(outs[0].shape)

    # generting random color for the 80 classes in coco
    colors = np.random.uniform(0, 255, size=(len(classes), 3))

    # Extract information on the view
    class_ids = []
    confidences = []
    boxes = []

    for out in outs:
        for detection in out:
            # extract score values
            scores = detection[5:]
            # Object id
            class_id = np.argmax(scores)
            # confidence score for each object ID
            confidence = scores[class_id]

            # if confidence > 0.5 and class_id == 0:
            if confidence > 0.5:
                # Extract values to draw bounding box
                # replace the width0 and height0 with width, height for writing the boxes on resized image
                center_x = int(detection[0] * width0)
                center_y = int(detection[1] * height0)
                w = int(detection[2] * width0)
                h = int(detection[3] * height0)
                # Rectangle coordinates
                x = int(center_x - w / 2)
                y = int(center_y - h / 2)
                boxes.append([x, y, w, h])
                confidences.append(float(confidence))
                class_ids.append(class_id)

    indexes = cv2.dnn.NMSBoxes(boxes, confidences, 0.5, 0.4)
    # Draw bounding box with text for each object
    font = cv2.FONT_HERSHEY_COMPLEX_SMALL
    ordered_classes = {"label": [], "confidence": [], "boxes": []}

    objects = []
    object_count = defaultdict(int)
    for i in range(len(boxes)):
        if i in indexes:
            x, y, w, h = boxes[i]
            ordered_classes["boxes"].append([x, y, w, h])
            label = str(classes[class_ids[i]])
            ordered_classes["label"].append(label)
            confidence_label = int(confidences[i] * 100)
            ordered_classes["confidence"].append(confidence_label)
            object_count[str(label)] += 1

            objects.append({"label": label, "confidence": confidence_label, "box": [x, y, w, h]})
            
            # color = colors[i]
            # cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
            # cv2.putText(img, f'{label}', (x+25, y + 75), font, 1, color, 1)

    # Write output image (object detection output)
    # output_image_path = os.path.join(app.config['UPLOAD_FOLDER'], 'output_image.jpg')
    # cv2.imwrite(output_image_path, img)

    # return(output_image_path, ordered_classes, object_count)
    return {
        "objects": objects,
        "counts": object_count,
        "height": height0,
        "width": width0,
    }


app = FastAPI()


@app.get("/")
async def read_root():
    return {"message": "Welcome to object detection API"}


@app.post("/detect/")
async def model_inference(file: UploadFile = File(...)):
    image_data = await file.read()
    image_name = file.filename
    np_image = np.frombuffer(image_data, dtype=np.uint8)

    # decode the image from the NumPy array
    image = cv2.imdecode(np_image, cv2.IMREAD_UNCHANGED)

    # print(image.shape)
    result = await detect_object(image)

    return {"filename": image_name, **result}


if __name__ == "__main__":
    PORT = int(os.environ.get("PORT", 5111))
    uvicorn.run("object_detector_api:app", host="0.0.0.0", port=PORT)
