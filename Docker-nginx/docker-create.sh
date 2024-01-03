#!/bin/bash

IMAGENAME="socunzombi-nginx-img"
IMAGETAG="1.0"
CONTAINERNAME="socunzombi-nginx-container"

echo "First, let's check that you don't have the container running."
echo ""
if [[ $(docker ps --quiet --filter name=$CONTAINERNAME) ]]; then
    echo "It seems you have already a container with the name $CONTAINERNAME, so we will delete it."
    docker stop $CONTAINERNAME
    docker rm $CONTAINERNAME
    echo "Container deleted, lets proceed to create the new container."
    echo "" 
fi

echo "Secondly, we'll check you don't have the image created."
if [[ $(docker image list --quiet $IMAGENAME:$IMAGETAG) ]]; then
    echo "It seems you have already an image with the name $IMAGENAME, so we will delete it."
    docker image rm $(docker image list --quiet $IMAGENAME:$IMAGETAG)
    echo "Image deleted, lets proceed to create the new image."
    echo "" 
fi

echo "Now we'll proceed to the creation of the image: "
echo ""
docker build --no-cache --tag $IMAGENAME:$IMAGETAG .
echo "Image created!"
echo ""

echo "Last but not least, we'll create our docker container with our image."
docker run --detach --publish 80:80 --name $CONTAINERNAME $IMAGENAME:$IMAGETAG

echo ""
echo "Container created, now you can test the app: http://localhost:80"
echo ""
echo "If you want to delete all, just copy the following lines: (Be awared, with the following lines you will delete ALL you have in docker.)"
echo "docker stop $CONTAINERNAME && \\"
echo "docker rm $CONTAINERNAME && \\"
echo "docker system prune --all --volumes"
