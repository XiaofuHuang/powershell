
# ---------------------------- 查看操作 ----------------------------
# 查看您的AKS集群的信息
az aks show --resource-group ${resourceGroup} --name ${aksCluster} --output table

# 查看自动扩展日志
kubectl get configmap -n kube-system cluster-autoscaler-status -o yaml

# 查看可用区
kubectl describe nodes | grep -e "Name:" -e "failure-domain.beta.kubernetes.io/zone"
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}'

exit
# ---------------------------- 创建操作 ----------------------------
az aks create --resource-group ${resourceGroup} --name ${aksCluster} `
    --node-count 1 `
    --generate-ssh-keys

# 选项

# 配置拉取镜像
# --attach-acr $acrName

# 具有Uptime SLA(服务级别协议)的集群(付费)
# --uptime-sla

# 创建标准负载均衡器的一个池的集群
# The Basic load balancer SKU is not supported when using multiple node pools. By default, AKS clusters are created with the Standard load balancer SKU from the Azure CLI and Azure portal.
# --load-balancer-sku standard --vm-set-type VirtualMachineScaleSets

# 启动集群自动缩放
# -enable-cluster-autoscaler
# --min-count 1
# --max-count 3

# 建立多个可用区
# --zones 1 2 3

# 默认只有一个系统专用池

# ---------------------------- 缩放操作 ----------------------------

# 手动缩放 如果只有一个node pool
az aks scale --resource-group $resourceGroup --name $aksCluster --node-count 3

# 对现有集群启动自动缩放
az aks update --resource-group $resourceGroup --name $aksCluster `
    --enable-cluster-autoscaler `
    --min-count 1 `
    --max-count 3

# 对现有集群修改自动缩放设置
az aks update --resource-group $resourceGroup --name $aksCluster `
    --update-cluster-autoscaler `
    --min-count 1 `
    --max-count 3
#   增加配置
#   --cluster-autoscaler-profile scan-interval=30s
#   清空配置
#   --cluster-autoscaler-profile ""

# 对现有集群禁止自动缩放设置
az aks update --resource-group $resourceGroup --name $aksCluster `
    --disable-cluster-autoscaler `

# ---------------------------- 升级操作 ----------------------------
# 获取升级可用的集群版本
az aks get-upgrades --resource-group ${resourceGroup} --name ${aksCluster}

# Tips: 一次只能升级一个次要版本。例如，可以从1.14.x升级到1.15.x，但不能直接从1.14.x升级到1.16.x。
#       要升级从1.14.x到1.16.x，首先升级从1.14.x到1.15.x，然后执行另一个升级从1.15.x到1.16.x。
# 该升级作用于集群控制平面, 将升级所有的node pool
$KUBERNETES_VERSION = ""
az aks upgrade --resource-group $resourceGroup --name $aksCluster --kubernetes-version $KUBERNETES_VERSION

# Preview 浪涌升级
# TODO


# kured (KUbernetes REboot Daemon) 
# 查看需要重启的 Linux 节点，然后自动重新调度运行中的 Pod 并处理节点重启进程
# 默认情况下，AKS 中的 Linux 节点会每晚检查更新, 如果有可用的安全更新或内核更新，则会自动下载并进行安装。
# 部分安全更新（如内核更新）需要重启节点才能完成更新进程。 需要重启的 Linux 节点会创建名为 /var/run/reboot-required 的文件。 此重启进程不会自动进行。

# 手动检查更新
# 1. 使用 SSH 连接到 Azure Kubernetes 服务 https://docs.microsoft.com/zh-cn/azure/aks/ssh
# 2. sudo apt-get update && sudo apt-get upgrade -y

## 安装脚本
## Add the Kured Helm repository
helm repo add kured https://weaveworks.github.io/kured
## Update your local Helm chart repository cache
helm repo update
## Create a dedicated namespace where you would like to deploy kured into
kubectl create namespace kured
## Install kured in that namespace with Helm 3 (only on Linux nodes, kured is not working on Windows nodes)
helm install kured kured/kured --namespace kured --set nodeSelector."beta\.kubernetes\.io/os"=linux

# 查看更新状态
kubectl get nodes --output wide

# ---------------------------- 停止/启动 操作 ----------------------------

# Preview

# ---------------------------- 删除操作 ----------------------------
# 删除集群
# Tips: AAD不会被删除, 详情https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal#additional-considerations

# az group delete --name $resourceGroup --yes --no-wait
