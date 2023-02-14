## synapse-matrix

### to test locally run

```
cp envs/example.synpase envs/synapse
```
change any vars if required in envs/synapse

Run this everytime you which to spin up synapse locally
```
docker-compose up --build --force-recreate --remove-orphans synapse
```
Run this to stop it
```
docker stop $(docker ps | grep "synapse" | awk '{print($1)}')
```