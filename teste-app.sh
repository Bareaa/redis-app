#!/bin/bash

RESULT=$(wget -qO- http://localhost:8090/)

if [ $? -eq 0 ]; then
  echo "Serviço no ar!"
elif [[ $RESULT == *"Number of visits is"* ]]; then
    echo "Ok - Number of visits"
    echo $RESULT
else
    echo "Not Ok - Number of visits"
    exit 1
fi
