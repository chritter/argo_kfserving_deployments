#!/bin/bash

MODEL_NAME=max-object-detector
NAMESPACE=christian-ritter
SERVICE_HOSTNAME=$(kubectl get inferenceservice -n ${NAMESPACE} ${MODEL_NAME} -o jsonpath='{.status.url}' | cut -d "/" -f 3)

curl -k -v -F "image=@anil-arora.jpg" https://${SERVICE_HOSTNAME}/model/predict
