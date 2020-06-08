for N in 1 2 3
do
    docker stop -t 0 node$N
    docker rm node$N
    sudo rm -rf ./d$N
done
