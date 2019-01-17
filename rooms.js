exports = module.exports = function(io, socket, connection, roomList, moment) {
    const message = require('./message');
    
    moment.locale('pl');
    
    function addRoom(callback) {
        connection.query('SELECT roomname, room_id FROM rooms WHERE Public="1"', function (error, rows) {
            if (error) throw error;
            for (var i in rows) {
                callback(rows[i]);
            }
        });
    };//addRoom
    
    function removeRoom(callback) {
        connection.query('SELECT roomname, room_id FROM rooms WHERE Public="0"', function (error, rows) {
            if (error) throw error;
            for (var i in rows) {
                callback(rows[i]);
            }
        });
    };//removeRoom

    function roomArray() {
        addRoom(function (data) {
            if (!roomList.filter(function(roomList) {return roomList.roomname == data.roomname}).length > 0){
                roomList.push(data); 
            };
            roomList.sort(compare);
        });//addRoom

        removeRoom(function (data) {
            var index = roomList.map(function(e) { return e.roomname; }).indexOf(data.roomname);
            if (index != -1) roomList.splice(index, 1);
            roomList.sort(compare);
        });//removeRoom
    }//roomArray 
    
    function compare(a, b) {
        if (a.room_id < b.room_id) return -1;
        else return 1;
        return 0;
    }//compare

    function updateRooms() {
        io.to(socket.id).emit('roomsdata', {room: roomList});
        }//updateRooms
    
    function liveUpdate() {
        io.emit('roomsdata', {room: roomList}); 
    }
    
    roomArray();
    updateRooms();
    socket.on('showhide', function(roomstatus, roomprivacy) {
        var room_status = roomstatus.status
        var room_privacy = roomprivacy.privacy
        
        connection.query('UPDATE mydb.rooms SET Public = ? WHERE room_id = ?', [room_privacy, room_status], function(error, result, rows){
            if(error) throw error;
            console.log('Changed ' + result.changedRows + ' rows');
            console.log(roomList);
            roomArray();
            liveUpdate();
        });//connection.query
            console.log(roomList);
    });//socket on showhide
    
    socket.on('cr', function(data) {
        let room = socket.rooms[Object.keys(socket.rooms)[0]];
        if (room === data) return 0;
        changeRoom(socket.userID, socket.room, data);
    });//socket on cr  
    
    var enterRoom = function(nickname, room) {
        var post = {user_id: undefined, username: nickname, ip: 'asd'};
        connection.query('INSERT INTO mydb.users SET?', post, function (err, result) {
            if (err) throw err;
            registerInRoom(result.insertId, room);
            usersInRoom(room);
            socket.userID = result.insertId;
        });
        
        console.log(socket.id);
    };//enterRoom
    
    function registerInRoom (user, room) {
        var post_room = {Users_user_id: user, Rooms_room_id: room, ur_id: undefined};
        connection.query('INSERT INTO mydb.users_has_rooms SET ?', post_room, function(err) {
            if (err) throw err;
            socket.join(room);
            socket.room = room; 
            report(room, 1);
            message.load();
        });
    };//registerInRoom
    
    var changeRoom = function(user, oldroom, newroom) {
        var godzina = moment().format('LTS');
        connection.query('UPDATE mydb.users_has_rooms SET Rooms_room_id = ? WHERE Users_user_id = ?', [newroom, user], function(err, result) {
            if (err) throw err;
            socket.leave(oldroom);
            socket.join(newroom);
            socket.room = newroom;
            usersInRoom(newroom);
            usersInRoom(oldroom);
            report(oldroom, -1);
            report(newroom, 1);
            message.load();
            io.to(socket.id).emit('new message', {
                nick: 'System',
                time: godzina,
                msg: "You are now in room " + newroom + ' ' +  socket.nickname
            });
        });
    }//changeRoom
    
    var leaveRoom = function(user, room) {
        connection.query('DELETE FROM mydb.users_has_rooms WHERE Users_user_id = ?', user, function(err, result) {
            console.log("user with id " + user + " has left the room");
            report(room, -1);
        });
    }//leaveRoom
    
    var usersInRoom = function(room_id) {
        var listOfUsers = [];
        connection.query('SELECT users.username FROM users_has_rooms INNER JOIN users ON users_has_rooms.Users_user_id = users.user_id WHERE users_has_rooms.Rooms_room_id = ?', room_id, function(err, rows) {
            if (err) throw err;
            for (var i in rows) {
                listOfUsers.push(rows[i].username);
            }
            io.in(room_id).emit('uir', listOfUsers);
        });//query
    };//usersInRoom
    
    socket.on('data request', function(data, callback) {
        connection.query('SELECT roomname, room_id, SUM(CASE WHEN mydb.users_has_rooms.Rooms_room_id IS NULL THEN 0 ELSE 1 END) AS total FROM mydb.rooms LEFT JOIN mydb.users_has_rooms ON rooms.room_id = users_has_rooms.Rooms_room_id GROUP BY roomname', function(err, rows){
            if (err) throw err;
            callback(rows);
        });
    });//data request
    
    function report(room, joined) {
        var data = {room: room, join: joined};
        socket.broadcast.emit('report', data);
    };
    
    module.exports.enter = enterRoom;
    module.exports.leave = leaveRoom;
};
