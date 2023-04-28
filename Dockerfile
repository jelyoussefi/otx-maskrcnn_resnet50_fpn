FROM openvino/ubuntu20_dev:latest
ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt update -y

RUN mkdir -p  /workspace/
WORKDIR /workspace 
RUN git clone https://github.com/openvinotoolkit/training_extensions.git && \
	cd training_extensions && git checkout develop

WORKDIR /workspace/training_extensions
 
#RUN python3 -m venv .otx
RUN pip3 install torch==1.13.1 torchvision==0.14.1 --extra-index-url https://download.pytorch.org/whl/cu117 

RUN apt install -y python3-dev
RUN pip3 install -e .[full] 
RUN pip3 install tox

WORKDIR /workspace 
COPY train.sh /workspace 

