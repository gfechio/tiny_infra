#!/bin/bash

echo "Run the folllwing commands to stress your application:"

echo "Add a new tmux session and run this : watch 'kubectl get hpa'"

echo "kubectl run -it --rm load-generator --image=busybox /bin/sh"

echo "Hit enter on your container and run the following"

echo "while true; do wget -q -O- http://YOUR_APP_ENDPOINT; done"
