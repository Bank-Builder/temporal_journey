# Docker Tips
Some of the more useful docker commands when experimenting with docker containers.

## stop all containers:
```
docker stop $(docker ps -a -q)
```

## stop all containers by force
```
docker kill $(docker ps -q)
```

## remove all containers
```
docker rm $(docker ps -a -q)
```

## remove all docker images
```
docker rmi $(docker images -q)
```

## purge the rest
```
docker system prune --all --force --volumes
```
