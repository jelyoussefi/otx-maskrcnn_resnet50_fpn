pip3 install mmcv-full==1.7.1 > /dev/null
otx_optimize Custom_Counting_Instance_Segmentation_MaskRCNN_ResNet50 \
	--workspace ./maskrcnn-ws \
	--load-weights ./models/nncf/FP32/openvino.xml \
	--output ./models/nncf/INT8
