# Morse decoder application on Erlang cluster(Kubernetes)

It is a poc project that shows how to implement distributed morse-decoder on erlang cluster.

## To setup
  * Install dependencies with `mix deps.get`
  * Test with  `mix test`

### To run 
 * Local enviroment star with `MIX_ENV=dev PORT=4001 iex -S mix phx.server`. LibCluster strategy is Gossip for dev env. Start other erlang vm with different port then they will connect each others and form cluster.
 
 * Prod env runs on kubernets cluster. It uses k8 headless service to discovery node and form cluster. To deploy kubernets steps are below. (Minikube)
 
 ```
 
    docker build -t morse-decoder:latest .
   
    minikube cache add morse-decoder:latest 
    
    kubectl create -f k8s/morse-decoder-nodes-svc.yaml 
    
    kubectl create -f k8s/morse-decoder-nodes-svc.yaml 
    
    kubectl create -f k8s/morse-decoder.yaml 
    
    kubectl create -f k8s/morse-decoder-public-svc.yaml
    
```


 
