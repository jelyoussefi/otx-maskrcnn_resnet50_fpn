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
	-v ${CURRENT_DIR}/dataset:/workspace/dataset \
	-v ${CURRENT_DIR}/output:/workspace/output \
	-v /tmp/.X11-unix:/tmp/.X11-unix  -v ${HOME}/.Xauthority:/home/root/.Xauthority \
	-v ${CURRENT_DIR}/.cache:/root/.cache \
	${DOCKER_IMAGE_NAME}
	
#----------------------------------------------------------------------------------------------------------------------
# Targets
#----------------------------------------------------------------------------------------------------------------------
default: train
.PHONY:  

build:
	@$(call msg, Building Docker image ${DOCKER_IMAGE_NAME} ...)
	@docker build . -t ${DOCKER_IMAGE_NAME}
	
train: build
	@$(call msg, Training the maskrcnn-resnet50-fpn model  ...)
	@docker run ${DOCKER_RUN_PARAMS} bash



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
