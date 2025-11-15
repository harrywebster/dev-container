# dev-container

A docker container used to developed within, maintain consistaency between workstations with single platform.

## Build
```
docker build -t dev-workstation .
```

## Start
```
docker run -d --rm -p 2222:22 --hostname container --name dev-workstation dev-workstation
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 developer@localhost -p 2222
```

## Stop
```
docker stop dev-workstation
```
