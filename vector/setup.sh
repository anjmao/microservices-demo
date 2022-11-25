#!/bin/bash

set -e

kubectl create ns poc
kubectl apply -f tetra-vector-config.yaml -n poc
helm upgrade -i grafana grafana/grafana -n poc -f ./grafana.yaml
helm upgrade -i loki grafana/loki-simple-scalable -n poc -f ./loki.yaml
helm upgrade -i tetragon cilium/tetragon -n poc -f ./tetragon.yaml
helm upgrade -i vector vector/vector -n poc -f ./vector.yaml
helm upgrade -i metrics vm/victoria-metrics-single -n poc -f ./victoria-metrics-values.yaml
kubectl apply -f https://raw.githubusercontent.com/cilium/tetragon/main/crds/examples/tcp-connect.yaml