#!/bin/bash

docker build -t sabir_app .
docker tag sabir_app sabirrafiq/reactjs-demo:latest
docker push sabirrafiq/reactjs-demo:latest
