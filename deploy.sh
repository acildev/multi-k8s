docker build -t acilsutr/multi-client:latest -t acilsutr/multi-client:$SHA -f ./client/Dockerfile ./cient
docker build -t acilsutr/multi-server:latest -t acilsutr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t acilsutr/multi-worker:latest -t acilsutr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push acilsutr/multi-client:latest
docker push acilsutr/multi-server:latest
docker push acilsutr/multi-worker:latest

docker push acilsutr/multi-client:$SHA
docker push acilsutr/multi-server:$SHA
docker push acilsutr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=acilsutr/multi-server:$SHA
kubectl set image deployment/client-deployment client=acilsutr/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=acilsutr/multi-worker:$SHA
