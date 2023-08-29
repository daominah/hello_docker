export dockerImgTag=daominah/python37
docker build --tag=${dockerImgTag} .

# this `daominah/python37` image was used in many projects, do NOT update base
# image from ubuntu:18.04 to ubuntu:22.04
docker push ${dockerImgTag}
