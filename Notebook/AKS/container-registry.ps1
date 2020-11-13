# ---------------------------- 设置变量 ----------------------------
$acrName = "xiaofuacr"
# ---------------------------- 查看操作 ----------------------------

# ---------------------------- 创建操作 ----------------------------
# 创建容器注册表
az acr create -n $acrName -g $resourceGroup --sku basic
# 创建集群并绑定到集群上
az aks create -n $aksCluster -g $resourceGroup --generate-ssh-keys --attach-acr $acrName
# 现有的 AKS 群集配置 ACR 集成
az aks update -n $aksCluster -g $resourceGroup --attach-acr $acrName

# ---------------------------- 修改操作 ----------------------------
# 从 Docker Hub 导入到 ACR
az acr import  -n $acrName --source docker.io/library/nginx:latest --image nginx:v1