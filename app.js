const express = require('express');//Load express module
const app = express(); // assign express to app
var port = process.env.PORT || 3000;
const path = require('path'); //Load path module
const io = require('socket.io').listen(app.listen(port));
const moment = require('moment');
const mysql = require('mysql');
const connection = mysql.createConnection({
    host    : 'serwerkm.mysql.database.azure.com',
    user    : 'adminkm@serwerkm',
    password: 'zaq1@WSX',
    database: 'mydb',
        port: 3306,
    insecureAuth: true
});

const exp = require('./express')(app, express, path, connection);
const database = require('./database')(connection);

var roomList = [];

io.on('connection', function(socket){
    const user = require('./user')(io, roomList, connection, socket, moment);
    const message = require('./message')(io, socket, moment, connection);
    const rooms = require('./rooms')(io, socket, connection, roomList, moment);
});

console.log("\x1b[1m\x1b[32mRunning on port 3000\x1b[0m");

module.exports.connection = connection;