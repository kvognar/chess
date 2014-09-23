var createChat = function(server) {
  var io = require('socket.io')(server);
  var guestNumber = 1;
  var nicknames = {};

  io.on('connection', function (socket) {
    // add user nickname
    var newUserName = "Guest_" + guestNumber++;
    nicknames[socket.id] = newUserName;
    socket.emit('nicknameAssignment', { nickname: newUserName });
    
    
    var nicknameValues = [];
    for (var key in nicknames) {
      nicknameValues.push(nicknames[key]);
    }
    socket.emit('allUsers', { users: nicknameValues });
    
    io.emit('newUserJoins', { nickname: newUserName });
    
    socket.on('messageSubmission', function (data) {
      io.emit('message', { user: nicknames[socket.id], 
                           text: data.message });
    });
    
    socket.on('nicknameChangeRequest', function (data) {
      var success = true;
      for (var nick in nicknames) {

        if (data.nickname === nick) {
          success = false;
        }
      }
    
      if (success) {
        //emit new nick to all clients
        var oldNick = nicknames[socket.id];
        console.log("OLD NICK: " + oldNick);
        console.log(nicknames);
        nicknames[socket.id] = data.nickname;
        socket.emit('nicknameAssignment', { nickname: data.nickname });
        io.emit('nicknameChange', { 
          nickname: data.nickname, 
          oldNickname: oldNick 
        });
      
      } else {
        socket.emit('rejectedNickname', { message: "invalid nickname" });
      }
    });
    
    socket.on('disconnect', function () {
      console.log(nicknames)
      io.emit('userExit', { nickname: nicknames[socket.id] });
      delete nicknames[socket.id];
      console.log(nicknames)
    });  
    
    
  });
  

  
    
};

module.exports = createChat;