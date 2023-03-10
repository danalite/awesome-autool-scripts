# https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.6/deploy/docker/hubserving/
# FROM paddlepaddle/paddle:2.0.0

# FROM ubuntu:20.04
# ARG DEBIAN_FRONTEND=noninteractive
# RUN apt update
# RUN apt install -y python3-pip \
#     build-essential libssl-dev libffi-dev python3-dev git
# RUN apt-get install ffmpeg libsm6 libxext6 -y
# RUN pip3 install --upgrade pip 
# RUN pip3 install paddlehub --upgrade 

FROM registry.baidubce.com/paddlepaddle/paddle:2.0.0
ARG DEBIAN_FRONTEND=noninteractive
RUN pip3.7 install --upgrade pip
RUN pip3.7 install paddlehub --upgrade

RUN git clone https://github.com/PaddlePaddle/PaddleOCR.git /PaddleOCR

WORKDIR /PaddleOCR
RUN pip3 install -r requirements.txt 
RUN pip3 install paddlepaddle paddleocr>=2.0.1

RUN mkdir -p /PaddleOCR/inference/
ADD https://paddleocr.bj.bcebos.com/PP-OCRv3/chinese/ch_PP-OCRv3_det_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_PP-OCRv3_det_infer.tar -C /PaddleOCR/inference/

ADD https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_cls_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_ppocr_mobile_v2.0_cls_infer.tar -C /PaddleOCR/inference/

# Change rec_model_dir in deploy/hubserving/ocr_system/params.py）
ADD https://paddleocr.bj.bcebos.com/PP-OCRv3/chinese/ch_PP-OCRv3_rec_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_PP-OCRv3_rec_infer.tar -C /PaddleOCR/inference/

RUN hub install deploy/hubserving/ocr_system/

EXPOSE 8866
CMD ["/bin/bash", "-c", "hub serving start -m ocr_system -p 8866"]