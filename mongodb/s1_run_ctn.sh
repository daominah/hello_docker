export DATA_DIR=${PWD}/data_db

docker run -dit --name=mongodb4 \
     --volume ${DATA_DIR}:/data/db \
     -p 27017:27017 \
     daominah/mongodb4
