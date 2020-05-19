docker build -t linneakawe/multi-client:latest -t linneakawe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t linneakawe/multi-server:latest -t linneakawe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t linneakawe/multi-worker:latest -t linneakawe/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push linneakawe/multi-client:latest
docker push linneakawe/multi-client:$SHA
docker push linneakawe/multi-server:latest
docker push linneakawe/multi-server:$SHA
docker push linneakawe/multi-worker:latest
docker push linneakawe/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=linneakawe/multi-server:$SHA
kubectl set image deployments/client-deployment client=linneakawe/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=linneakawe/multi-worker:$SHA