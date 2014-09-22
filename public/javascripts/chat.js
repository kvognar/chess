$(function () {
  if (typeof ChatApp === 'undefined') {
    window.ChatApp = {};
  }

  ChatApp.Chat = function (socket) {
    this.socket = socket;
  };

  ChatApp.Chat.prototype.sendMessage = function (msg) {
    this.socket.emit('messageSubmission', { message: msg });
  };
});