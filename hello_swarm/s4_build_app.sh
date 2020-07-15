export appVersion=0.1.0
docker build --tag=daominah/example_app:${appVersion} .
docker push daominah/example_app:${appVersion}
