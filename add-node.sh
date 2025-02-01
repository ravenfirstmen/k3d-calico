#!/usr/bin/env bash

# -- Get token
token=$(k3d cluster list k3s-default --token -o json | jq -r '.[].clusterToken')

# -- New server node -- 
echo "For server nodes, run: "
cat <<EOT 
k3d node create [server node name] \\
   --role server \\
   --k3s-node-label 'label/nodegroup=infra' \\
   --token '$token' \\
   --cluster k3s-default
EOT

# -- New agent node -- 
echo "For worker nodes, run: "
cat <<EOT 
k3d node create [worker node name] \\
   --role agent \\
   --k3s-node-label 'label/nodegroup=jobs' \\
   --token '$token' \\
   --cluster k3s-default
EOT