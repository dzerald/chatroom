exports = module.exports = function(app, express, path, connection) {
    //Load chatroom.html from public catalog. With __diraname we can make in server files catalog for front-end files
    app.get('/', function(req, res) {
        res.sendFile(path.join(__dirname + '/public/chatroom.html'));
    });

    //This function allows html to load files from child directory.
    app.use(express.static(__dirname + '/public'));
}