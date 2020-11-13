$resourceGroup = "xiaofhua"
$aksCluster = "xiaofhuaAksCluster"
$namespace = "teamscloud-runtime-xiaofhuav2"
# az login
az aks get-credentials --resource-group $resourceGroup --name $aksCluster
kubectl config set-context --current --namespace=$namespace