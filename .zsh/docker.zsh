#docker
alias d='docker'
alias db='docker build'
alias dimls='docker image ls'
alias dim='docker image'
alias dc='docker container'
alias dnt='docker network'

#unprivileged docker shell
alias ds='docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" -u "$(id -u):$(id -g)" -it debian:13-slim'
alias kali='docker run --tty --interactive kalilinux/kali-rolling /bin/bash'
#docker compose
alias d-up='docker-compose up -d'
alias d-down='docker-compose down'

#wipe all docker resources
alias dnuke="docker stop $(docker ps -a -q); docker rm -f $(docker ps -a -q); docker rmi -f $(docker images -a -q); docker volume rm -f $(docker volume ls -q)"

#lazydocker
alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /yourpath:/.config/jesseduffield/lazydocker lazyteam/lazydocker'

#portainer
alias portainer='docker run --name portainer -p 9000:9000 -d -v "/var/run/docker.sock:/var/run/docker.sock" portainer/portainer-ce:latest'
alias portainerstop='docker stop portainer'
alias portainerstart='docker start portainer'

#gcp docker cli
alias gcloud='docker run --rm --volumes-from gcloud-config gcr.io/google.com/cloudsdktool/google-cloud-cli gcloud'


#juiceshop docker container
alias juiceshop='docker run --name juiceshop -d --rm -p 3000:3000 bkimminich/juice-shop'

#terraform-docs
#alias tf-docs='docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.20.0 markdown /terraform-docs'
