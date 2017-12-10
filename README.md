# samza_router_service
Samza router Kubernetes Service


1. Minikube

1.1 Install

brew cask install minikube
Install docker-machine-driver-xhyve:
https://gist.github.com/codesword/423d80ea29849410dcc97c3542450955

1.2 Start minikube
minikube start --vm-driver=xhyve --cpus 4 --memory 8192
minikube dashboard

1.3 To work with the docker daemon
eval $(minikube docker-env)

2. Setup Kubernetes env

2.1 Clone customized kubernetes-kafka-small
https://github.com/danielcoman/kubernetes-kafka-small

2.2 In the repo folder deploy the two clusters
kubectl apply -f ./kafka-main
kubectl apply -f ./kafka-replica

3. Setup Router Service

3.1 Clone samza_router_service
https://github.com/danielcoman/samza_router_service

3.2 Build the docker image
In the repo folder copy the samza router code/bin/scripts in the deploy/samza folder
Add or your own or use the config from config-example folder

docker-compose -f ./docker/build.yml build  

3.3 Deploy Router Service
kubectl apply -f ./router_service

4. Profit

kubectl get po --all-namespaces

kubectl exec -it kafka-0   /bin/bash  -n kafka-source
kubectl exec -it kafka-0   /bin/bash  -n kafka-destination
