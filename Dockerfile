FROM openvino/ubuntu20_dev:latest
ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt update -y
RUN apt install -y wget software-properties-common python3-dev libgl1 libglib2.0-0  python3-tk python3-opencv 

# Installing cuda
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt update -y
RUN apt install -y cuda-toolkit-11-6
RUN pip3 install torch==1.13.1+cu116 torchvision==0.14.1+cu116 -f https://download.pytorch.org/whl/cu116/torch_stable.html	

# Installing otx
WORKDIR /tmp 
RUN git clone https://github.com/openvinotoolkit/training_extensions.git && \
	cd training_extensions && git checkout 63d9d7a8b3b0ae2e339a9806ba76a9d05d3c1c63 
		 
WORKDIR /tmp/training_extensions
 
RUN pip3 install -e .[full] 

RUN mkdir -p  /workspace/
WORKDIR /workspace 

COPY build.sh train.sh  optimize.sh export.sh export_nncf.sh  test.sh /workspace



