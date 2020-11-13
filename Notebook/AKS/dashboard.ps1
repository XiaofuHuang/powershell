az aks browse --resource-group $resourceGroup --name $aksCluster
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard