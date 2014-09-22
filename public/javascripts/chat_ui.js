$(function () {
  if (typeof ChatApp === 'undefined') {
    window.ChatApp = {};
  }

  ChatApp.ChatUI = function (chat) {
    this.chat = chat;
    this.chat.socket.on('message', this.addMessage);

  };
  
  ChatApp.ChatUI.prototype.addMessage = function (msg) {
    console.log(msg);
    var $bla = $('<li></li>');
    $bla.text(msg.text);
    $('#messages').prepend($bla);
  };

  ChatApp.ChatUI.prototype.sendMessage = function (event) {
    event.preventDefault();
    var msg = $('#message-input').val();
    this.chat.sendMessage(msg);
  };
});