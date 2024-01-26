#!/bin/bash -x

docker build \
   -f Dockerfile \
   -t springboot-og \
   .

docker run \
  --name springboot-checkpoint-container \
  --privileged \
  --env WLP_CHECKPOINT=afterAppStart \
  springboot-og 

docker commit springboot-checkpoint-container springboot
docker rm springboot-checkpoint-container

