$resourceGroup = "aks-env"
$aksCluster = "mods-test-shared"
$namespace = "teamscloud-runtime-xiaofhuav2"
# az login
az aks get-credentials --resource-group $resourceGroup --name $aksCluster
kubectl config set-context --current --namespace=$namespace