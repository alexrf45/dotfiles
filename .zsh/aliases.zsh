
#arch commands
alias reload='. ~/.zshrc'
alias update='sudo pacman -Syyu'
alias i='sudo pacman -S'
alias vim='nvim'
alias tree-overview='tree -D -L 2'

#tmux
alias t='tmux new -f ~/.tmux.conf -s $1'

#networking
alias public='curl wtfismyip.com/text'

#aws-vault
alias awsv='aws-vault exec Administrator'
alias awsv-acct-admin='aws-vault exec account-admin --duration=2h'

#python
alias py='python3'

#ssh

#tor
alias tor='docker run --rm --detach --name tor --publish 9050:9050 tor:test'


#scripts
alias arch-mirror='~/.config/scripts/./arch-mirror.sh'
alias terraform-project='~/.config/scripts/./terraform-skel.sh $1'
alias dockershell='~/.config/scripts/./dockershell.sh'
alias ec2-list='~/.config/scripts/./ec2list.sh'
alias s3-create='python3 ~/.config/scripts/s3.py'
alias aws-services-list='~/.config/scripts/./services.sh'
alias tf-project='~/.config/scripts/./terraform-skel.sh'
alias s3-backend-delete='~/.config/scripts/./s3-backend-delete.sh'

#terraform
alias tf='terraform'
alias tfa='terraform apply'
alias tfv='terraform validate'
alias tfp='terraform plan'
alias tfs='terraform state'
alias tfsls='terraform state list'
alias tfo='terraform output'
alias tfinit='terraform init'
alias tfd='terraform destroy'
alias tff='terraform fmt'

#aws cli aliases
alias ec2-check='aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId,Id:InstanceId}" --filters "Name=instance-state-name,Values=running" --output table'
alias s3-list="aws s3api list-buckets | jq -r '.Buckets[].Name'"
alias vpc-check='aws ec2 --output text --query "Vpcs[*].{VpcId:VpcId,Name:Tags[?Key=='Environment'].Value|[0],CidrBlock:CidrBlock}" describe-vpcs'
alias s3-delete='aws s3api delete-bucket --bucket ${BUCKET}'

#cloud-nuke aws
alias aws-nuke='cloud-nuke aws --exclude-resource-type s3 --exclude-resource-type iam --exclude-resource-type secretsmanager --exclude-resource-type dynamodb'
alias aws-nuke-view-us-east-1='cloud-nuke inspect-aws --region us-east-1'

#docker
alias d='docker'
alias dimls='docker image ls'
alias dim='docker image'
alias dct='docker container'
alias dps='docker ps'
alias dnt='docker network'


#docker compose
alias dockup='docker-compose up -d'
alias dockdown='docker-compose down'


alias config='/usr/bin/git --git-dir=/home/r0land/.cfg/ --work-tree=/home/r0land'
