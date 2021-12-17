#!/bin/bash

MODEL_NAME=max-object-detector
NAMESPACE=sdep
SERVICE_HOSTNAME=$(kubectl get inferenceservice ${MODEL_NAME} -o jsonpath='{.status.url}' | cut -d "/" -f 3)
curl -k -v -F "image=@anil-arora.jpg" https://${SERVICE_HOSTNAME}/model/predict