FROM python:3.9-slim

# Source: https://github.com/jbantony/Object-Detection-Counter-API
LABEL maintainer="vrteee <support@autool.site>"
ENV DEBIAN_FRONTEND = noninteractive

RUN apt-get update && yes | apt-get upgrade && \
    apt-get install ffmpeg libsm6 libxext6 curl  -y

RUN mkdir -p /odapi
RUN apt-get install -y python3-pip
WORKDIR /odapi

COPY . .
RUN pip install -r requirements.txt
ADD https://pjreddie.com/media/files/yolov3.weights /odapi/models

WORKDIR /odapi
ENTRYPOINT ["python"]

CMD ["object_detector_api.py"]