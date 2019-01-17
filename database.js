exports = module.exports = function(connection) {
    //Connect to database as root
    connection.connect(function(err) {
        if (err) {
            console.error('error connecting: ' + err.stack);
            return;
        };
    });//connection.connect
    
    connection.query('TRUNCATE users_has_rooms', function(err) {
        if (err) throw err;
    });
}