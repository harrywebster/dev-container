# dev-container

A docker container used to developed within, maintain consistaency between workstations with single platform.

## Build
```
docker build -t dev-workstation .
```

## Start
```
docker run -d --rm -p 2222:22 --hostname container --name dev-workstation -v ~/Project:/home/developer/project dev-workstation
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 developer@localhost -p 2222
```

## Install persistant packages

*You only need to run this once per physical machine.*

```
seutp-ai
```

## Stop
```
docker stop dev-workstation
```
