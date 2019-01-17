$(document).ready(function() {
    var socket = io.connect();
    
    $('.klikam').on('click', function(e) {
        e.preventDefault();
        var roomstatus = {status: $(this).data("room")};
        var roomprivacy = {privacy: $(this).data("privacy")};
        socket.emit('showhide', roomstatus, roomprivacy);
    });//klikam
    
    $('.flood').on('click', function(e) {
        e.preventDefault();
        var roomstatus = {status: $(this).data("room")};
        var roomflood = {flood: $(this).data("flood")};
        socket.emit('flood', roomstatus, roomflood);
    });//flood
    var data;
    
    socket.emit('data request', data, function(data) {
        if(data) {
            for(var i = 0; i < data.length; i++) {
                $('#stats').append('<div data-room=' + data[i].room_id + '>' + data[i].roomname + ': ' + '<span id="amount">' + data[i].total + '</span></div>');
            };
        };//if
    });//data request
    
    socket.on('report', function(data) {
        var $look = $('*[data-room="' + data.room + '"]').children('#amount');
        var value = parseInt($look.text(), 10);
        $look.empty();
        if(data.join == 1) {
            $look.append(value + 1);
        } else if (data.join == -1) {
            $look.append(value - 1);
        };
    });//report
});