var createChat = function(server) {
  var io = require('socket.io')(server);

  io.on('connection', function (socket) {
    socket.emit('greeting', { greeting: 'good morning' });
    socket.on('reply', function (data) {
      console.log(data);
    });
    socket.on('messageSubmission', function (data) {
      io.emit('message', { text: data.message })
    })
  });
  
};

module.exports = createChat;