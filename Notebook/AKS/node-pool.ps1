# ---------------------------- 设置变量 ----------------------------
$nodePoolName = "xiaofupool"

# ---------------------------- 查看操作 ----------------------------

# 获取节点池名字
az aks show --resource-group $resourceGroup --name $aksCluster --query agentPoolProfiles
# 查看某个节点池信息
az aks nodepool show --resource-group $resourceGroup --cluster-name $aksCluster --name $nodePoolName
# 查看所有节点池状态
az aks nodepool list --resource-group $resourceGroup --cluster-name $aksCluster
# 获取节点
kubectl get nodes
# 查看pod 与 node间关系
kubectl get pods -A -o wide
exit

# ---------------------------- 创建操作 ----------------------------


# 添加节点池
# VmSize default -> Standard_DS2_v2, OrchestratorVersion default 与控制平面相同
az aks nodepool add --resource-group $resourceGroup --cluster-name $aksCluster --name $nodePoolName `
    --node-count 3 `

# 指定节点池VM大小
# --node-vm-size Standard_NC6 `
# 指定节点池污点, 污点只能在创建期间指定
# --node-taints sku=gpu:NoSchedule `
# 指定label, label只能在创建期间指定
# --labels dept=IT costcenter=9999
# 指定Azure Tag, 可以被修改
# --tags dept=IT costcenter=9999

# 自定义使用的节点池脚本
az aks nodepool add --resource-group $resourceGroup --cluster-name $aksCluster --name $nodePoolName `
    --node-count 3 `

# 使用ARM Template管理节点池 (json文件)
# https://docs.microsoft.com/zh-cn/azure/aks/use-multiple-node-pools#manage-node-pools-using-a-resource-manager-template
$filename = ""
az group deployment create --resource-group $resourceGroup --template-file $filename

# Preview 具有唯一子网的节点池

# Preview 为节点池分配公共ip

# ---------------------------- 修改操作 ----------------------------

# 向现有集群添加一个系统节点池
# 创建节点池后，无法通过 CLI 更改节点污点
az aks nodepool add --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --node-count 3 `
    --node-taints CriticalAddonsOnly=true:NoSchedule `
    --mode System

# 将系统节点池更改为用户节点池
az aks nodepool update -g $resourceGroup --cluster-name $aksCluster -n $nodePoolName --mode user

# 将用户节点池更改为系统节点池
az aks nodepool update -g $resourceGroup --cluster-name $aksCluster -n $nodePoolName --mode system

# ---------------------------- 缩放操作 ----------------------------

# 手动缩放
az aks nodepool scale `
    --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --node-count 4 `
    --no-wait


# 启用自动缩放
az aks nodepool update `
    --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 5

# 修改自动缩放
az aks nodepool update `
    --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --update-cluster-autoscaler `
    --min-count 1 `
    --max-count 5

# 禁止自动缩放
az aks nodepool update `
    --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --disable-cluster-autoscaler

# ---------------------------- 升级操作 ----------------------------
# 获取升级可用的集群版本
az aks get-upgrades --resource-group ${resourceGroup} --name ${aksCluster}

# 升级节点池
$KUBERNETES_VERSION = ""
az aks nodepool upgrade `
    --resource-group $resourceGroup `
    --cluster-name $aksCluster `
    --name $nodePoolName `
    --kubernetes-version $KUBERNETES_VERSION `
    --no-wait
    
    

# ---------------------------- 删除操作 ----------------------------
# az aks nodepool delete -g $resourceGroup --cluster-name $aksCluster -n $nodePoolName
