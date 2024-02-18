#/bin/bash
RESULT=$(wget -qO- http://localhost:8100/)

if [ $? -eq 0 ]; then
    echo 'ok - serviço no ar!'
elif [[ $RESULT == *"Number"* ]]; then
    echo 'ok - number of visits'
    echo $RESULT
else
    echo 'not ok - number of visits'
    echo "Resposta do servidor: $RESULT"
    exit 1
fi
