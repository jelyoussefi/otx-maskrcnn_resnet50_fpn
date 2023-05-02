mkdir -p ./models/FP32/
rm -rf ./models/FP32/nncf/*
otx_export --workspace maskrcnn-ws --load-weights ./models/nncf/weights.pth  --output ./models/nncf/FP32

rm -rf ./models/FP16/nncf/*
otx_export --workspace maskrcnn-ws --load-weights ./models/nncf/weights.pth --half-precision --output ./models/nncf/FP16


