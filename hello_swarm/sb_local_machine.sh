localMachine=local

for i in 0 1 2; do
    docker-machine create --driver virtualbox local${i}
done

# print IP addresss of local machines
for i in 0 1 2; do
    docker-machine ip local${i}
done
