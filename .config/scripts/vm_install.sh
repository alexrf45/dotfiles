virt-install \
  --virt-type kvm \
  --name "$1" \
  --location "$2" \
  --os-variant "$3" \
  --disk size="$4" \
  --memory "$5"
