#!/bin/sh

export CORE_NS=${1:-phuet-5gcore}
export DEST_NS=uetest

# echo ${CORE_NS}

export AMF_ADDR=$(oc -n ${CORE_NS} get svc amf-open5gs-sctp -o jsonpath='{.spec.clusterIP}')
export AMF_PORT=$(oc -n ${CORE_NS} get svc amf-open5gs-sctp -o jsonpath='{.spec.ports[0].port}')

echo helm install -n ${DEST_NS} ueransim ueransim --set amf.address=$AMF_ADDR --set amf.port=$AMF_PORT
