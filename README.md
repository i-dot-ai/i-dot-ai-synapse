## synapse-matrix

### to test locally run

```
cp envs/example.synapse envs/synapse
```
change any vars if required in `envs/synapse`




Run the `docker-compose` command below when you want to spin up synapse locally:
```
docker-compose up --build --force-recreate --remove-orphans synapse
```
The above command will spin up a `postgres` and `synapse-matrix` container.


Run the `docker stop` command below to stop the containers.
```
docker stop $(docker ps | grep "synapse" | awk '{print($1)}')
```