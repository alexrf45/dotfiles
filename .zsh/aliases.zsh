
#arch commands
alias reload='. ~/.zshrc'
alias update='sudo pacman -Syyu'
alias i='sudo pacman -S'
alias vim='nvim'
#tmux
alias t='tmux -f ~/.tmux.conf -s $1'

#networking
alias public='curl wtfismyip.com/text'

#aws-vault
alias awsv='aws-vault exec Administrator'
alias awsv-acct-admin='aws-vault exec account-admin'

#python
alias py='python3'

#ssh

#scripts
alias terraform-project='~/.config/scripts/./terraform-skel.sh $1'
alias dockershell='~/.config/scripts/./dockershell.sh'
#terraform
alias tf='terraform'
alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfs='terraform state'
alias tfo='terraform output'

#aws cli aliases
alias ec2-check='aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId,Id:InstanceId}" --filters "Name=instance-state-name,Values=running" --output table'
alias s3-list="aws s3api list-buckets | jq -r '.Buckets[].Name'"
alias vpc-check='aws ec2 --output text --query "Vpcs[*].{VpcId:VpcId,Name:Tags[?Key=='Environment'].Value|[0],CidrBlock:CidrBlock}" describe-vpcs'


#docker
alias dck='docker'
alias dckils='docker image ls'
alias dcki='docker image'
alias dckc='docker container'
alias dckp='dcoker ps'
alias dckn='docker network'


#docker compose
alias dockup='docker-compose up -d'
alias dockdown='docker-compose down'


alias config='/usr/bin/git --git-dir=/home/r0land/.cfg/ --work-tree=/home/r0land'
