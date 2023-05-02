otx_build Custom_Counting_Instance_Segmentation_MaskRCNN_ResNet50 \
	--workspace ./maskrcnn-ws \
	--train-data-roots ./dataset/ \
	--val-data-roots ./dataset/
	
cd ./maskrcnn-ws && \
	find . -name "*" -type f -exec sed -i 's/800/640/g' {} \; && \
	find . -name "*" -type f -exec sed -i 's/1344/640/g' {} \; && \
	sed -i 's/load_from = .*/load_from = "https:\/\/download.pytorch.org\/models\/maskrcnn_resnet50_fpn_coco-bf2d0c1e.pth"/' model.py
		 
