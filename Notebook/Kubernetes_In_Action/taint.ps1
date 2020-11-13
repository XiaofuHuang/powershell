# 显示主节点的污点信息 Taints内条目表示污点信息
kubectl get nodes -A
kubectl describe node aks-agentpool-39743879-vmss000001

# 显示kube-proxy pod污点容忍度 Tolerations内条目表示污点容忍度信息
kubectl get pods -n kube-system
kubectl describe pod kube-proxy-2zwqd -n kube-system