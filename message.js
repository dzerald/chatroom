exports = module.exports = function (io, socket, moment, connection) {
    //When server receives data for 'send message' function emit data to all sockets and log in server console
    const export_socket_to_flood = require('./flood.js')(io, socket);
    const flood = require('./flood.js');
    moment.locale('pl');
    
    socket.on('send message', function (data) {
        var godzina = moment().format('LTS');
        var datetime = moment().format('YYYYMMDDHHmmss');
        flood.init(socket.room);

        var post = {
            m_id: undefined,
            text: data.msg,
            date: datetime,
            users_id: socket.userID,
            r_id: socket.room
        };

        connection.query('INSERT INTO mydb.messages SET ?', post, function (err, result) {
            if (err) throw err;
            io.in(socket.room).emit('new message', {
                msg: data.msg,
                time: godzina,
                nick: socket.nickname
            });
            new_messages++;
        }); //connetion.query
    }); //send message
    
    var new_messages = 0;
    var counter = 0;
    var offset = 0;
    
    socket.on('cr', function() {
        counter = 0;
        new_messages = 0;
    });
    
    var load_messages = function () {
        offset = counter * 20 + new_messages;
        connection.query('SELECT text, date, username FROM mydb.messages LEFT JOIN mydb.users ON messages.users_id = users.user_id WHERE r_id = ? ORDER BY m_id DESC LIMIT 20 OFFSET ?', [socket.room, offset], function(err, result){
            if (err) throw err;
            socket.emit('archive', result);
            counter++;
        });
    };
    
    socket.on('archive', function(callback){
        offset = counter * 20 + new_messages;
        connection.query('SELECT text, date, username FROM mydb.messages LEFT JOIN mydb.users ON messages.users_id = users.user_id WHERE r_id = ? ORDER BY m_id DESC LIMIT 20 OFFSET ?', [socket.room, offset], function(err, result){
            if (err) throw err;
            callback(result);
            counter++;
        });
    });
    
    module.exports.load = load_messages;
}; //exports