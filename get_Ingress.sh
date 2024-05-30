#!/bin/bash

##3
##get all ingress on the cluster
get_all_ingresses() {
  kubectl get ingress --all-namespaces -o json
}

## get from json
get_load_balancer_ingresses() {
  jq -r '
    .items[] | 
    select(.status.loadBalancer.ingress != null) | 
    {
      namespace: .metadata.namespace,
      name: .metadata.name,
      lb_ingresses: [.status.loadBalancer.ingress[] | {ip: .ip, hostname: .hostname}]
    }
  '
}

# Function to print Ingress details
print_ingress_details() {
  jq -r '
    "Namespace: \(.namespace)\nName: \(.name)\nLoadBalancer Ingresses: \(.lb_ingresses)\n-----"
  '
}

# Main script execution
all_ingresses=$(get_all_ingresses)
lb_ingresses=$(echo "$all_ingresses" | get_load_balancer_ingresses)
echo "$lb_ingresses" | print_ingress_details
