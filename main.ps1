# Delete resource
kubectl delete pods ${pod} 
exit

# debug ingress controller
kubectl logs  

kubectl get deployment -o yaml

kubectl get deployments 
kubectl describe deployments 
kubectl rollout status deployment/teamscloud-runtime-xiaofhuav1

kubectl get events -n ${namespace}