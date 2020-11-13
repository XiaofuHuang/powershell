# 查看您的AKS集群的版本
az aks show --resource-group ${resourceGroup} --name ${aksCluster} --query kubernetesVersion --output table

# 获取升级可用的集群版本
az aks get-upgrades --resource-group ${resourceGroup} --name ${aksCluster}