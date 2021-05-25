# Containerized UERANSIM for Kubernetes

This is a first try to get UERANSIM containerized for Kubernetes/OpenShift environment.

## To use this project

```bash
% git clone git@github.com:clustership/ueransim-k8s.git
% cd ueransim-k8s/
% oc new-project ueransim-demo
```

Try to identify AMF address and port to connect from gNB using SCTP:

```bash

% export AMF_ADDR=$(oc -n 5gcore get svc amf-open5gs-sctp -o jsonpath='{.spec.clusterIP}')
% export AMF_PORT=$(oc -n 5gcore get svc amf-open5gs-sctp -o jsonpath='{.spec.ports[0].port}')

```

Deploy the helm chart:

```bash
helm install ueransim ueransim --set amf.address=$AMF_ADDR --set amf.port=$AMF_PORT
```


```bash

% export UE_POD=$(oc get pods --namespace ueransim-demo -l "app.kubernetes.io/name=ueransim,app.kubernetes.io/instance=ueransim,app.kubernetes.io/service=ueransim-nr-ue" -o jsonpath="{.items[0].metadata.name}")
% oc exec ${UE_POD} -- ping -I uesimtun0 www.google.com
``


# TODOS

* try to create a readinessProbe for ue pod to wait for gnb to be up before starting (or use an init container)
* put various tools in container images (tcpdump, wireshark, traceroute, nc, curl...) to get better experience.
