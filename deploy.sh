docker build -t hazelnut95/multi-client:latest -t hazelnut95/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hazelnut95/multi-server:latest -t hazelnut95/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hazelnut95/multi-worker:latest -t hazelnut95/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hazelnut95/multi-client:latest
docker push hazelnut95/multi-server:latest
docker push hazelnut95/multi-worker:latest
docker push hazelnut95/multi-client:$SHA
docker push hazelnut95/multi-server:$SHA
docker push hazelnut95/multi-worker:$SHA
kubectl -f apply k8s
kubectl set image deployments/server-deployment server=hazelnut/multi-server:$SHA
kubectl set image deployments/client-deployment client=hazelnut/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hazelnut/multi-worker:$SHA
