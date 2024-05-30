#!/bin/bash
##1

resource_grp="thera-r-grp"
aks_cluster_name="threa-cluster"


## Get the detailes of  nodpool 
##a
for pool in $(az aks nodepool list --resource-group $resource_grp --cluster-name $aks_cluster_name --query "[].name" -o tsv); do
  echo "Node Pool: $pool"
  az aks nodepool show --resource-group $resource_grp --cluster-name $aks_cluster_name --name $pool --query "{Name:name, NodeSize:vmSize, NodeCount:count, AutoscalerMin:minCount, AutoscalerMax:maxCount}" --output table
done



## Get STS/Deployments  and PVC site Details
##b
echo "Deployments and StatefulSets Resource Requests and Limits:"
namespaces=$(kubectl get ns --no-headers -o custom-columns=":metadata.name")

for ns in $namespaces; do
  echo "Namespace: $ns"
  echo "Deployments:"
  kubectl get deployments -n $ns -o json | jq -r '.items[] | [.metadata.name, .spec.template.spec.containers[] | {"Name": .name, "Requests": .resources.requests, "Limits": .resources.limits}] | @json' | jq -s .
  
  echo "STS:"
  kubectl get statefulsets -n $ns -o json | jq -r '.items[] | [.metadata.name, .spec.template.spec.containers[] | {"Name": .name, "Requests": .resources.requests, "Limits": .resources.limits}] | @json' | jq -s .


##c
  echo "PVC size:"
  kubectl get pvc -n $ns -o json | jq -r '.items[] | {Namespace: .metadata.namespace, Name: .metadata.name, Size: .spec.resources.requests.storage}'
done


## 2
## check the current version of the kubernetes on cluster


echo "The k8s version is "
kubectl version

