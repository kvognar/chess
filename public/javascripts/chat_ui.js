$(function () {
  if (typeof ChatApp === 'undefined') {
    window.ChatApp = {};
  }

  ChatApp.ChatUI = function (chat) {
    this.chat = chat;
    this.chat.socket.on('message', this.addMessage);
    this.users = [];
    this.chat.socket.on('newUserJoins', this.addUsername.bind(this));
    this.chat.socket.on('nicknameChange', this.switchUsername.bind(this));
    this.chat.socket.on('allUsers', this.initializeUsers.bind(this));
    this.chat.socket.on('userExit', this.removeUser.bind(this));
  };
  
  ChatApp.ChatUI.prototype.addMessage = function (msg) {
    console.log(msg);
    var $bla = $('<li></li>');
    $bla.text(msg.text);
    $('#messages').prepend($bla);
  };

  ChatApp.ChatUI.prototype.sendMessage = function (event) {
    event.preventDefault();
    //parse message for commands
    var msg = $('#message-input').val();
    var hasCommand = msg[0] === "/";
    if (hasCommand) {
      var parsedMsg = this.parseMessage(msg);
    }

    if (hasCommand) {
      if (parsedMsg.command === "invalidCommand") {
        this.chat.sendMessage(parsedMsg.message);
      } else if (parsedMsg.command === "/nick"){
        this.chat.sendNicknameRequest(parsedMsg.message);
      }
    } else {
      this.chat.sendMessage(msg);
    }
  };
  
  ChatApp.ChatUI.prototype.removeUser = function (data) {
    debugger;
    this.users.splice(this.users.indexof(data.nickname), 1);
    this.addMessage( { text: data.nickname + " has left the room."});
    this.renderUsernames();
  }
  
  ChatApp.ChatUI.prototype.initializeUsers = function (data) {
    this.users = data.users;
    this.renderUsernames();
  }
  
  ChatApp.ChatUI.prototype.renderUsernames = function (data) {
    $('#usernames').empty();
    this.users.forEach( function (username) {
      var $bla = $('<li></li>');
      $bla.text(username);
      $('#usernames').prepend($bla);
    });
  };
  
  ChatApp.ChatUI.prototype.addUsername = function (data) {
    this.users.push(data.nickname);
    this.renderUsernames();
  };
  
  ChatApp.ChatUI.prototype.switchUsername = function (data) {
    this.users[this.users.indexOf(data.oldNickname)] = data.nickname;
    this.renderUsernames();
  };
  
  ChatApp.ChatUI.prototype.parseMessage = function (msg) {
    commands = ['/nick']; // add /join later
    
    var result = { 
      command: "invalidCommand",
      message: "You entered an invalid command"
    };
    

    commands.forEach( function(command) {
      if (msg.substring(0, command.length) === command) {
        result = { 
          command: command, 
          message: msg.substring(command.length).trim()
        };
      };
       
    });
    
    return result;
  }
  
  
}); 