exports = module.exports = function (io, socket) {
    const app = require('./app');
    const connection = app.connection;
    const mess = require('./message');

    var lastmes = 0;
    var floodroom = [];

    connection.query('SELECT room_id FROM mydb.rooms WHERE flood ="1"', function (error, result, rows) {
            if (error) throw error;
            for (i = 0; i < result.length; i++) {
                floodroom.push(result[i].room_id);
            }
            console.log(floodroom);
    }); //connection.query
    
    socket.on('flood', function (roomstatus, roomflood) {
        var room_status = roomstatus.status;
        var room_flood = roomflood.flood;
        connection.query('UPDATE mydb.rooms SET flood = ? WHERE room_id = ?', [room_flood, room_status], function (error, result, rows) {
                if (error) throw error;
        }); //connection.query
    }); //flood
    
    module.exports.init = function(room){
        this.options = {
            enabled: mess.floodroom,
        }
        var room = parseInt(room);
        if(floodroom.includes(room)){
            var x = new Date().getTime();
            if(x - lastmes < 1000){
                console.log('lessthansec');
            };    
            lastmes = x;
        };//if
    };//module.exports.init/
};//module.exports