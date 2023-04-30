pip3 install mmcv-full==1.7.1
otx_train Custom_Counting_Instance_Segmentation_MaskRCNN_ResNet50 \
	--workspace ./maskrcnn-ws \
	--train-data-roots ./dataset/ \
	--val-data-roots ./dataset/ \
	--output /workspace/maskrcnn-ws
