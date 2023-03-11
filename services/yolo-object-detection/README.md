
### Localhost docker image
- https://johs.me/posts/object-detection-service-yolo-docker/

```bash
docker run -d --rm --name yolo_service -dp 8080:8080 --gpus all johannestang/yolo_service:1.0_cuda10.0_tc-yolov3_coco
```

### Rebuilding for use in LAN

```bash
gir clone https://github.com/johannestang/yolo_service.git
# Expose 8081 in dockerfile

export DOCKER_REPO="vrteee/yolo_service"
docker build -t $DOCKER_REPO:1.0_cuda10.0_tc-yolov3_coco \
	--build-arg weights_file="yolov3.weights" \
	--build-arg config_file="data/yolov3.cfg" \
	--build-arg meta_file="data/coco.data" \
	--build-arg build_image="nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04" \
	--build-arg app_image="nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04" \
	--build-arg cuda=1 \
	--build-arg cuda_tc=1 \
    . 

# Start the service
docker run -d --rm --name yolo_service -p 8081:8081 --gpus all docker.io/vrteee/yolo_service:1.0_cuda10.0_tc-yolov3_coco
```


### Using the prebuilt image

```bash
docker run -dit --rm --name test_yolo -p 9999:8080 johannestang/yolo_service:1.0_cuda10.0_tc-yolov3_coco

sleep 5
curl -L https://github.com/AlexeyAB/darknet/raw/master/data/person.jpg -o person.jpg 

curl -X POST -F 'image_file=@person.jpg' -F threshold=0.25 'http://localhost:9999/detect'

curl -X GET 'http://localhost:9999/detect?url=https%3A%2F%2Fgithub.com%2FAlexeyAB%2Fdarknet%2Fraw%2Fmaster%2Fdata%2Fperson.jpg'

docker stop test_yolo
```