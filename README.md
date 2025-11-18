# dev-container

A docker container used to developed within, maintain consistaency between workstations with single platform.

## Build

Create a directory in the root called `.ssh` and move in your SSH key pair that you wish to use in github.com and create a `.ssh/authorized_key` file with your SSH public key in it, then build the image:
```bash
docker build -t dev-workstation .
```

## Start
```bash
PATH_TO_PROJECT="/Users/harry/Project"
docker run -d --rm -p 2222:22 --hostname container --name dev-workstation -v $PATH_TO_PROJECT:/home/developer/project -v /var/run/docker.sock:/var/run/docker.sock dev-workstation
```

Connect to the container:
```bash
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 developer@localhost -p 2222
```

## On first boot, install persistant packages

*You only need to run this once per physical machine.*

```
sudo chmod 666 /var/run/docker.sock
sudo chown -R developer:developer /home/developer/project
seutp-ai
```

## Stop
```
docker stop dev-workstation
```
