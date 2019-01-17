$(document).ready(function () {
    // SOCKET FUNCTIONS
    // GLOBAL VARIABLES
    const socket = io.connect();
    var currentRoom;

    socket.on('roomsdata', function (data) {
        $('#room option, #chatWrap button').remove();
        for (var i in data.room) {
            const d = data.room[i];
            $('#room').append('<option value="' + d.room_id + '">' + d.roomname + '</option>');
            $('#chatWrap').append('<button class="rb" type="button" data-room=' + d.room_id + '>' + d.roomname + '</button>');
        }
    });

    socket.on('usernames', function (data) {
        var html = '';
        for (i = 0; i < data.length; i++) {
            html += data[i] + '<br/>'
        }
        $('#users').html(html);
    });

    socket.on('new message', function (data) {
        //Append data.nick and data.msg to chat in one line
        $('#chat').append('[' + data.time + '] ' + '<b>' + data.nick + ':</b> ' + data.msg + "<br/>")
        console.log("new message");
        changeTitle();
    });

    socket.on('system', function (data) {
        $('#chat').append('<b>' + data.msg + '</b><br>');
        currentRoom = data.currentRoom;
    });

    socket.on('uir', function (data) {
        $('#users, #nou').empty();
        for (var i in data) {
            $('#users').append('<b>' + data[i] + '</b><br>');
        };
        $('#nou').append(data.length);
    });

    $('#setNick').submit(function (e) {

        //Prevent page from reloading
        e.preventDefault();

        var user_data = {
            nickname: $('#nickname').val(),
            room: $('#room').val()
        };

        //Emit user_data object to server which has 'new user' function.
        socket.emit('new user', user_data, function (data) {
            //???
            if (data) {
                $('#nickWrap').hide();
                $('#contentWrap').show();
            } else {
                $('#nickError').html('Username taken. Try another one.');
            }
        });

        //After submit clean nickname field
        $('#nickname').val('');
    });

    var enabled;
    var count = 0;
    var title = document.title;

    function changeTitle() {
        if (enabled == 1) {
            count++;
            var newTitle = '(' + count + ') ' + title;
            document.title = newTitle;
        }
    }

    $('#send-message').submit(function (e) {
        e.preventDefault();
        var data = {
            msg: $('#message').val(),
            room: currentRoom
        };
        socket.emit('send message', data);
        $('#message').val('');
    });

    var hidden, visibilityChange;
    if (typeof document.hidden !== "undefined") {
        hidden = "hidden";
        visibilityChange = "visibilitychange";
    } else if (typeof document.msHidden !== "undefined") {
        hidden = "msHidden";
        visibilityChange = "msvisibilitychange";
    } else if (typeof document.webkitHidden !== "undefined") {
        hidden = "webkitHidden";
        visibilityChange = "webkitvisibilitychange";
    }

    function handleVisibilityChange() {
        if (document[hidden]) {
            enabled = 1;
        } else {
            count = 0;
            enabled = 0;
            document.title = title;
        }
    }

    document.addEventListener("visibilitychange", handleVisibilityChange, false);

    $(document).on('click', '.rb', function () {
        let r = $(this).data("room");
        socket.emit('cr', r.toString());
        currentRoom = r.toString();
        $("#chat").empty();
    });

    $('#contentWrap').hide();
    
    function addZero(i){
        if (i<10) {
            i = "0" + i;
        }
        return i;
    };
    
    function arch(data) {
        if (data) {
            for(let i = 0; i < data.length; i++){
                let t = new Date(data[i].date);
                let h = addZero(t.getUTCHours());
                let m = addZero(t.getUTCMinutes());
                let s = addZero(t.getUTCSeconds());
                $("#chat").prepend('[' + h + ':' + m + ':' + s + ']<b>' + data[i].username + '</b>: ' + data[i].text + '<br>');
            };//for
        };//if
    };//arch
    
    socket.on('archive', function(data) {
        arch(data);
    });
    
    $('#archive').on('click', function (e) {
        e.preventDefault();
        socket.emit('archive', function (data) {    
            arch(data);
        });//archive
    });//onclick
});//document