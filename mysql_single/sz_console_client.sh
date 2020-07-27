export MY_PASSWORD=123qwe

docker run -it --rm --network=host mysql:8.0.20 \
    mysql -h127.0.0.1 -uroot -p${MY_PASSWORD}

# CREATE DATABASE schema0 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
