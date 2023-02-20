docker build -t dhirendrabyte/multi-client:latest -t dhirendrabyte/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dhirendrabyte/multi-server:latest -t dhirendrabyte/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dhirendrabyte/multi-worker:latest -t dhirendrabyte/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dhirendrabyte/multi-client:latest
docker push dhirendrabyte/multi-server:latest
docker push dhirendrabyte/multi-worker:latest

docker push dhirendrabyte/multi-client:$SHA
docker push dhirendrabyte/multi-server:$SHA
docker push dhirendrabyte/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dhirendrabyte/multi-server:$SHA
kubectl set image deployments/client-deployment client=dhirendrabyte/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dhirendrabyte/multi-worker:$SHA