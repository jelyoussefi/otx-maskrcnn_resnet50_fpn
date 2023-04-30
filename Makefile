#----------------------------------------------------------------------------------------------------------------------
# Flags
#----------------------------------------------------------------------------------------------------------------------
SHELL:=/bin/bash
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))


#----------------------------------------------------------------------------------------------------------------------
# Docker Settings
#----------------------------------------------------------------------------------------------------------------------
DOCKER_IMAGE_NAME=otx-maskrcnn_resnet50_fpn-image
export DOCKER_BUILDKIT=1

DOCKER_RUN_PARAMS= \
	-it --rm -a stdout -a stderr -e DISPLAY=${DISPLAY} -e NO_AT_BRIDGE=1  \
	--device /dev/dri \
	--gpus all \
	-v ${CURRENT_DIR}/dataset:/workspace/dataset \
	-v ${CURRENT_DIR}/maskrcnn-ws:/workspace/maskrcnn-ws \
	-v ${CURRENT_DIR}/models:/workspace/models \
	-v /tmp/.X11-unix:/tmp/.X11-unix   -v ${HOME}/.Xauthority:/home/root/.Xauthority \
	-v ${CURRENT_DIR}/.cache:/root/.cache \
	${DOCKER_IMAGE_NAME}
	
	


#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
default: train
.PHONY:  

build:
	@$(call msg, Building Docker image ${DOCKER_IMAGE_NAME} ...)
	@docker build --rm . -t ${DOCKER_IMAGE_NAME}
	
train: build
	@$(call msg, Training the maskrcnn-resnet50-fpn model  ...)
	@mkdir -p ./maskrcnn-ws
	@docker run ${DOCKER_RUN_PARAMS} bash


quantize: build
	@$(call msg, Quantizing the maskrcnn-resnet50-fpn model  ...)
	@mkdir -p ./maskrcnn-ws
	@docker run ${DOCKER_RUN_PARAMS} bash

export: build
	@$(call msg, Exporting the maskrcnn-resnet50-fpn model  ...)
	@mkdir -p ${CURRENT_DIR}/models
	@docker run ${DOCKER_RUN_PARAMS} bash

test: build
	@$(call msg, Testing the maskrcnn-resnet50-fpn model  ...)
	@xhost +
	docker run ${DOCKER_RUN_PARAMS} bash
	
monitor:
	@$(call msg, Monitoring ...)
	@tensorboard --logdir=${CURRENT_DIR}/maskrcnn-ws/logs/tf_logs/ --bind_all
	
#----------------------------------------------------------------------------------------------------------------------
# helper functions
#----------------------------------------------------------------------------------------------------------------------
define msg
	tput setaf 2 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo  "" && \
	echo "         "$1 && \
	for i in $(shell seq 1 120 ); do echo -n "-"; done; echo "" && \
	tput sgr0
endef

