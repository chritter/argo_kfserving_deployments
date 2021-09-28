# Predict on a InferenceService using a Custom Image

## Creation of Docker Image

I build the docker image with `Dockerfile` and pushed it to `chritter/custom-sample`. With that the next step of creating
the inference server can be initated.

## Create the InferenceService

In the `custom.yaml` file edit the container image and replace {username} with your Docker Hub username.

Apply the CRD

```
kubectl apply -f custom.yaml
```

Expected Output

```
$ inferenceservice.serving.kubeflow.org/custom-sample created
```

## Check if deployment works

`kubectl get inferenceservice`

Status == False  indicates there is a problem. Dive deeper and get description

`kubectl describe inferenceservice custom-sample`

results in error message:


    Predictor:
      Name:  custom-sample-predictor-default-vl89g
Events:
  Type     Reason         Age                From                  Message
  ----     ------         ----               ----                  -------
  Warning  InternalError  50s                kfserving-controller  Operation cannot be fulfilled on services.serving.knative.dev "custom-sample-predictor-default": the object has been modified; please apply your changes to the latest version and try again
  Normal   Updated        48s (x2 over 50s)  kfserving-controller  Updated InferenceService "custom-sample"


> Further work below was not testsed on AAW.


## Run a prediction
The first step is to [determine the ingress IP and ports](../../../../README.md#determine-the-ingress-ip-and-ports) and set `INGRESS_HOST` and `INGRESS_PORT`

```
MODEL_NAME=custom-sample
SERVICE_HOSTNAME=$(kubectl get inferenceservice ${MODEL_NAME} -o jsonpath='{.status.url}' | cut -d "/" -f 3)

curl -v -H "Host: ${SERVICE_HOSTNAME}" http://${INGRESS_HOST}:${INGRESS_PORT}/v1/models/${MODEL_NAME}:predict
```

Expected Output

```
*   Trying 184.172.247.174...
* TCP_NODELAY set
* Connected to 184.172.247.174 (184.172.247.174) port 31380 (#0)
> GET /v1/models/custom-sample:predict HTTP/1.1
> Host: custom-sample.default.example.com
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< content-length: 31
< content-type: text/html; charset=utf-8
< date: Thu, 13 Feb 2020 21:34:54 GMT
< server: istio-envoy
< x-envoy-upstream-service-time: 15
<
Hello Python KFServing Sample!
* Connection #0 to host 184.172.247.174 left intact
* Closing connection 0
```
