#!/bin/bash
print_in_colour() {
  local red="\e[1;31;27m"
  green="\e[1;32;27m"
  yellow="\e[1;33;27m"
  blue="\e[1;34;27m"
  default="\e[0m"
  colour=$1

  if [ -z "$2" ]; then
    eval echo -e '$'${colour}
    exit
  fi

  eval echo -e '$'${colour}
  echo "${@:2}"
  echo -e "${default}"
}
get_help() {
  print_in_colour yellow "Options: "
  echo "--help"
  echo "node"
  echo "master"
  print_in_colour default
  exit
}
if [ -z "$1" ]; then
  print_in_colour red "An option must be supplied"
  get_help
  return 1
fi

# Master initialization
if [ $1 = "master" ]; then
output=$(kubeadm init ----apiserver-advertise-address=192.168.15.100)
while read -r line; do
  TEXT="kubeadm join"
  if echo $line | grep -q "$TEXT"; then
    echo "master initialization in progress";
    NODE=$(echo $line)
    echo $NODE > node_key
  elif echo $line | grep -q "$TEXT_DISCOVERY"; then
    NODE=$(echo $line)
    echo $NODE >> node_key
  else
    echo "no match";
 fi
  echo $line;
done <<< "$output"
# join node instruction

# kubeadm join
export KUBECONFIG=/etc/kubernetes/admin.conf
# netwok plugin weavenet
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
elif [ $1='node' ];
then
value=`cat key | tr -d '\n'`
eval $value

else
  echo "node configuration finished"
fi
