#!/bin/bash
#4
read -p "please enter namespace: " Namespace
read -p "please enter statefulset: " STS_Name
read -p "please enter key: " New_key
read -p "please enter new value: " New_value

kubectl get sts $STS_Name -n $Namespace -o yaml > $STS_Name+_sts.yaml

yq e '.spec.template.spec.nodeSelector = {"'$New_key'": "'$New_value'"}' -i $STS_Name+_sts.yaml

kubectl apply -f $STS_Name+_sts.yaml

rm $STS_Name+_sts.yaml

echo "Updated nodeSelector for StatefulSet $STS_Name in namespace $Namespace to $New_key=$New_value ${STS_Name}_sts.yaml"
