mkdir -p ./models/FP32/
rm -rf ./models/FP32/*
otx_export --workspace maskrcnn-ws --load-weights ./maskrcnn-ws/models/weights.pth  --output ./models/
mv ./models/openvino.bin ./models/openvino.xml  ./models/model.onnx ./models/FP32/
rm -rf ./models/confidence_threshold  ./models/config.json  ./models/label_schema.json  ./models/logs

mkdir -p ./models/FP16/
rm -rf ./models/FP16/*
otx_export --workspace maskrcnn-ws --load-weights ./maskrcnn-ws/models/weights.pth --half-precision --output ./models/
mv ./models/openvino.bin ./models/openvino.xml  ./models/model.onnx ./models/FP16/
rm -rf ./models/confidence_threshold  ./models/config.json  ./models/label_schema.json  ./models/logs
