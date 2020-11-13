# Get info
kubectl get pods 
kubectl get configmap 
kubectl get secret 
kubectl get service 
kubectl get service -A
kubectl get ingress -o yaml

kubectl get deployment -o yaml
kubectl get deployments
kubectl describe deployments 

# system events
kubectl get events -n ${namespace}

# pod logs
$pod = "teamscloud-runtime-xiaofhuav1-85c7b767b7-xfhns"
kubectl exec $pod -- ls /etc/
kubectl exec $pod -- curl http://10.0.37.142
kubectl logs $pod  


kubectl get deployment teamscloud-runtime-xiaofhuav2 -o yaml