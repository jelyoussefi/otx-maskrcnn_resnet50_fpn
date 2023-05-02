mkdir -p ./models/FP32/
rm -rf ./models/FP32/nncf/*
otx_export --workspace maskrcnn-ws --load-weights ./maskrcnn-ws/models/weights.pth  --output ./models/FP32
rm -rf  ./models/FP32/logs ./models/FP32/model.onnx

rm -rf ./models/FP16/nncf/*
otx_export --workspace maskrcnn-ws --load-weights ./maskrcnn-ws/models/weights.pth --half-precision --output ./models/FP16
rm -rf  ./models/FP16/logs ./models/FP16/model.onnx

otx_optimize Custom_Counting_Instance_Segmentation_MaskRCNN_ResNet50 \
	--workspace ./maskrcnn-ws \
	--load-weights ./models/FP32/openvino.xml \
	--output ./models/INT8
	
rm -rf  ./models/INT8/logs
