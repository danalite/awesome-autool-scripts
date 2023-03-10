FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 git -y
RUN pip install numpy opencv-python torch matplotlib

RUN git clone https://github.com/magicleap/SuperGluePretrainedNetwork.git /SuperGlue

WORKDIR /SuperGlue

# sudo docker run -it --gpus all superglue:gpu bash

# ./demo_superglue.py --input assets/freiburg_sequence/ --output_dir dump_demo_sequence --resize 320 240 --no_display