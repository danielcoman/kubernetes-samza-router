# samza_router_service
Samza router Kubernetes Service


## 1 Minikube

1.1 Install

brew cask install minikube
Install Hyperkit driver:
https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperkit-driver

1.2 Start minikube
```
minikube start --vm-driver=hyperkit --cpus 4 --memory 8192 --insecure-registry
minikube dashboard
```

1.3 To work with the docker daemon
```
eval $(minikube docker-env)
```

## 2 Setup Kubernetes env

2.1 Clone customized kubernetes-kafka-small
https://github.com/danielcoman/kubernetes-kafka-small

2.2 In the repo folder deploy the two clusters
```
kubectl apply -f ./kafka-main
kubectl apply -f ./kafka-replica
```

## 3 Setup Router Service

3.1 Clone samza_router_service
https://github.com/danielcoman/samza_router_service

3.2 Prepare bin

In the repo folder copy the samza router folder.
Add or your own or use the config from config-example folder.
```
tar -cvzf ./docker/image/router.tgz samza
```
Don't use nesting folders for samza router app tgz (ex: deploy/samza/...)

3.3 Build the docker image
```
docker-compose -f ./docker/build.yml build  
```

3.4 Deploy Router Service
```
kubectl apply -f ./router_service
```

## 4 Profit

```
kubectl get po --all-namespaces
```
Source:
```
kubectl exec -it kafka-0   /bin/bash  -n kafka-source
./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic thc-test
```
Destination:
```
kubectl exec -it kafka-0   /bin/bash  -n kafka-destination
./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic thc-test
```
