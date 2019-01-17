exports = module.exports = function(io, roomList, connection, socket, moment){
    const room = require('./rooms');
    var address = socket.request.connection._peername;
    
    moment.locale('pl');
    
    socket.on('new user', function(data, callback, id){
        callback(true);
        console.log(address);
        room.enter(data.nickname, data.room);
        //Assign data from client as socket.nickname
        socket.nickname = data.nickname;
        //Send to speciefied client (socket.id) welcome msg.
        var godzina = moment().format('LTS');
        io.to(socket.id).emit('new message', {
            nick: 'System',
            time: godzina,
            msg: "Welcome in room " + data.room + ' ' +  socket.nickname
        });
        //}
    });//socket.on('connect');
    
    socket.on('disconnect', function() {
        room.leave(socket.userID, socket.room);
    });

};