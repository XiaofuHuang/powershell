# 临时使用脚本更新image的tag

# 获取旧的deploymenmt
kubectl get deployment $deployment -o yaml
# 更新新版本的deployment
$deployment = "teamscloud-runtime-xiaofhuav2"
$container = "teams-cloud"
$image = "modstestshared.azurecr.io/xfsample:latest"
kubectl set image deployment $deployment $container=$image

# 获取新的deployment
kubectl get deployment $deployment -o yaml

# -----------------------------------------------------------------
# 不更新tag重新deploy所有pod
# TODO