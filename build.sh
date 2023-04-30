pip3 install mmcv-full==1.7.1 > /dev/null
otx_build Custom_Counting_Instance_Segmentation_MaskRCNN_ResNet50 \
	--workspace ./maskrcnn-ws \
	--train-data-roots ./dataset/ \
	--val-data-roots ./dataset/
