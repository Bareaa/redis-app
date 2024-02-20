const express = require('express');
const redis = require('redis');

const app = express();
app.disable("x-powered-by");
const client = redis.createClient({
    host: 'redis-server', // Nome do serviço do contêiner Redis no docker-compose.yml
    port: 6379 // Porta padrão do Redis
});

client.set('visits', 0);

app.get('/', (req, res) => {
    client.get('visits', (err, visits) => {
        visits = parseInt(visits) + 1;
        res.send('Number of visits is ' + visits);
        client.set('visits', visits);
    });
});

app.listen(8081, () => {
    console.log('Listening on port 8081');
});
