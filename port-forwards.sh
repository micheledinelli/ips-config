# Forward port 8888 on the backend service inside k8s to localhost:8888
kubectl port-forward svc/backend 8888:8888 & \

# Forward port 80 on the frontend service inside k8s to localhost:8080
kubectl port-forward svc/frontend 8080:80