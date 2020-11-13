# ---------------------------- 设置变量 ----------------------------
$serviceAccountName = "xfsa"
exit
# ---------------------------- 查看操作 ----------------------------
# 每个namespace都会有一个default的SA
kubectl get sa
kubectl get sa -A
# 查看sa信息, 包括sa token
kubectl describe sa $serviceAccountName

$satoken = "xfsa-token-f7mqx"
kubectl describe secret $satoken

# ---------------------------- 创建操作 ----------------------------
kubectl create serviceaccount $serviceAccountName

# ---------------------------- 修改操作 ----------------------------

# 添加注解, 让pod 只可以挂载serviceAccount指定的token