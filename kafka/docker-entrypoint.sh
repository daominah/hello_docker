# this file will be copied to mysql official image

echo "generate mysqld config file from env"
envsubst < "/conf_zoo.cfg_tpl" > "/conf/zoo.cfg"

# Write myid, if ZOO_MY_ID is null or unset, replace it with what's after :- (1)
if [[ ! -f "$ZOO_DATA_DIR/myid" ]]; then
    echo "${ZOO_MY_ID:-1}" > "$ZOO_DATA_DIR/myid"
fi

exec "$@"
