# ---------------------------- 设置变量 ----------------------------
$podName = "xftest"
$containerName = "xfcontainer"
exit
# ---------------------------- 查看操作 ----------------------------
kubectl get pods
kubectl get pods -A
kubectl get pods -A -o wide
kubectl get pod $podName -o yaml
# 显示pod以及标签
kubectl get pod --show-labels
# 通过标签显示器选择pod显示
kubectl get pod -L env

# 查看pod运行时状态
kubectl describe pod $podName

# 查看pod字段含义
kubectl explain pods
kubectl explain pod.spec

# 查看日志
kubectl logs $podName
kubectl logs $podName -c $containerName
exit
# ---------------------------- 调试操作 ----------------------------

# 查看日志
kubectl logs $podName
kubectl logs $podName -c $containerName

# 通过端口转发本地调试pod
$localPort = 8888
$podPort = 8080
kubectl port-forward $podName ${localPort}:${podPort}


# ---------------------------- 创建操作 ----------------------------

$podFile = "Notebook\Kubernetes\Pod\base-pod.yaml"
kubectl create -f $podFile

# 运行脚本
$podFile = "Notebook\Kubernetes\Pod\base-pod.yaml"
kubectl delete pod $podName
kubectl create -f $podFile


# ---------------------------- 缩放操作 ----------------------------

# 自动缩放 - 前提条件 Pod 定义了Resource 的requests 和 limits
# 所有Pod上的平均CPU利用率超过其的requests的50％，则会自动增加Pod
# Pod最多增加为10个实例。然后至少为部署3个实例
kubectl get deployment
$depolymentName = "teamscloud-runtime-xiaofhuav2"
kubectl autoscale deployment ${depolymentName} --cpu-percent=50 --min=3 --max=10
kubectl get pods

# 查看自动缩放状态
kubectl get hpa

# 也可以使用yaml文件 kind: HorizontalPodAutoscaler



# ---------------------------- 删除操作 ----------------------------
kubectl delete pod $podName