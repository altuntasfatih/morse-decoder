# Morse decoder application on Erlang cluster(Kubernetes)

It is a poc project that shows how to implement distributed morse-decoder on erlang cluster.

## To setup
  * Install dependencies with `mix deps.get`
  * Test with  `mix test`

### To run 
 * Local enviroment star with `MIX_ENV=dev PORT=4001 iex -S mix phx.server`.
 <br> LibCluster strategy is gossip therfore other erlang vm(on same network) then they will connect each others and form cluster.
 
 * Prod env runs on kubernets cluster. To deploy it steps are below. (Minikube)
  <br> In prod, k8 headless service is used to discovery node and form cluster.In additions global registry was used to support discovery of process on cluster. 
 ```
 
 docker build -t morse-decoder:latest .

 minikube cache add morse-decoder:latest 

 kubectl create -f k8s/morse-decoder-nodes-svc.yaml 

 kubectl create -f k8s/morse-decoder-nodes-svc.yaml 

 kubectl create -f k8s/morse-decoder.yaml 

 kubectl create -f k8s/morse-decoder-public-svc.yaml
    
```
### Endpoints
* POST  /v1/decoder/                                       -> Create new morse decoder session.
* PUT   /v1/decoder/:id                                    -> Decode morse code.
* GET   /v1/decoder/:id                                    -> Get plain text.
 
