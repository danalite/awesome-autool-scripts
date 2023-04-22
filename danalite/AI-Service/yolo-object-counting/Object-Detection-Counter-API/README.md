# YOLO ObjectDetection and Object Counter as API in Docker
API endpoint to run object detection and counting using YOLOv3. The user can send an image to the defined API endpoint and the detected results as well as the counts, will be received as response.


## Goal
The goal of this project is to test and demonstrate the AI-Serving concept, by deploying the Object Detection model as a docker image, so that any application can be interacted with this docker by making a POST request at the API endpoint with an image data and can receive the detection results and counts as the response. 

Object Detection API once deployed in a dockerfile shall receive the data input over a JSON Query and after inference generate the output and make it available in a JSON format.

The API has been developed in FastAPI and made available as docker. 

## Model
For the initial implementation a YOLOv3 model trainied on COCO dataset has been used in this configuration. This can detect the 80 different classes of objects as given in the COCO. The model weights can be downloaded from "https://pjreddie.com/media/files/yolov3.weights"


## Build the Docker
During the docker build, the YOLOv3 weights have been downloaded and integrated to the image. 

Build and tag the docker image using:
`docker build -t od-api .`

After sucessfull building, run the docker using:
`docker run -ti --rm -p 5000:5000 od-api`

## API Endpoints

#### Endpoint `/`

Gives a health message in JSON format as follows
` "message":"Welcome to object detection API" `

#### Endpoint `/detect/`

The endpoint `/detect/` is used to perform object detection on the given image. This return a JSON file in the below format:
```json
{
    "filename": "...",
    "detection results": {
        "detected objects":{
        "label": [...],
        "confidence": [...],
        "boxes": [[x,y,w,h], [x1,y1,w1,h1], ...]
    },
    "counts":{
        "class name": "no of instances", ...
    },
    "image height": ...,
    "image width": ...
    }
}
```

where the  `detection results` gives the information on the `detected objects` including the `label`, `confidence` and bounding `boxes`.  The `counts` gives the total count of each classes in the given image.
 

## Usage
After deploying the docker locally, one can make a POST request using the `curl` command:

`curl -X POST -F "file=@/path/to/image.jpg" http://localhost:5000/detect/` and gives the JSON data in the above mentioned format as response.

## Demo

The `/detect/` endpoint responses as follows: From FastAPI Documentation

![](docs/response1.png)

![](docs/response2.png)

Raw JSON data of the result:

```json

{
  "filename": "image1.jpg",
  "detection results": {
    "detected objects": {
      "label": [
        "person",
        "dog",
        "dog"
      ],
      "confidence": [
        64,
        99,
        99
      ],
      "boxes": [
        [
          777,
          5,
          247,
          438
        ],
        [
          19,
          37,
          304,
          499
        ],
        [
          352,
          77,
          683,
          519
        ]
      ]
    },
    "counts": {
      "person": 1,
      "dog": 2
    },
    "image height": 636,
    "image width": 1024
  }
}

```



## Notes
The latest OpenCV version 4.7 is having bugs and therefore the OpenCV version 4.6 has been used for the inference 

## TODO

- Extend the detect endpoint to send detected image. 
- Update the notebooks folder with the model generating notebook for a custom dataset
