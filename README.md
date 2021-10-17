# Jmeter Cluster Support for Kubernetes
 Let’s Jmeter running in kubernetes easily

## Prerequisits

Kubernetes > 1.16


## How to use   

1. Deploy and run load test   

	```bash
	# Deploy
	TEST_NAMESPACE=test
	kubectl create namespace ${TEST_NAMESPACE}
	kubectl -n ${TEST_NAMESPACE} apply -k .
	# Copy load test scripts
	kubectl -n ${TEST_NAMESPACE}  cp cloudssky.jmx  $(kubectl -n ${TEST_NAMESPACE} get po -o Name |grep master|sed -e  's#pod/##'):/ 
	# Run load test
	kubectl -n ${TEST_NAMESPACE}  exec -it $(kubectl -n ${TEST_NAMESPACE} get po -o Name |grep master) -- /load_test cloudssky.jmx 
	# Stop load test
	kubectl -n ${TEST_NAMESPACE}  exec -it $(kubectl -n ${TEST_NAMESPACE} get po -o Name |grep master) -- stoptest.sh
	```   

1. Use grafana dashboards
        
	```bash
	# Mac os
	kubectl -n ${TEST_NAMESPACE} port-forward service/jmeter-grafana  3000:3000 &
	open http://localhost:3000
	fg
	```
## Reference
base from 
https://goo.gl/mkoX9E
