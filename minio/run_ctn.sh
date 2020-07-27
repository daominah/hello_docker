# set envs by running `./env.sh`

if [ -z "${MINIO_SECRET_KEY}" ]; then
    echo "error: set envs (example in ./env.sh) before running container"
fi

baseImage=minio/minio:RELEASE.2020-07-27T18-37-02Z

docker run -dit --name minio \
    -p ${MINIO_PORT}:9000 \
    -e MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY} \
    -e MINIO_SECRET_KEY=${MINIO_SECRET_KEY} \
    ${baseImage} server ${MINIO_DATA_DIR}

# TODO: try distributed mode
