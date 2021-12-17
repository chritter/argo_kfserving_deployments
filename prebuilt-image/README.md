# Predict on a InferenceService using a prebuilt image

In this example we use a pre-build docker image which contains 
an object detector machine learning model and deploy it.


## Create the InferenceService

Apply the CRD

```
kubectl apply -f custom.yaml
```

Expected Output

```
inferenceservice.serving.kubeflow.org/max-object-detector created
```


## Check if deployment works

`kubectl get inferenceservice`

gives you state of the deployment via the `Ready` flag. Use

`kubectl describe inferenceservice max-object-detector`

for more details.

## Run a prediction

To run predict an object on the provided image `anil-arora.jpg`
we send a request to the KFServing API via

`./predict.sh`

which should return

```
{"status": "ok", "predictions": [{"label_id": "32", "label": "tie", "probability": 0.7970063090324402, "detection_box": [0.6801750659942627, 0.2899482250213623, 0.9958771467208862, 0.5204325914382935]}]}
* Connection #0 to host max-object-detector.seldonp.aaw.cloud.statcan.ca left intact
```


