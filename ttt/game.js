var Board = require("./board");

var Game = function(player1, player2) {
  this.p1 = player1;
  this.p2 = player2;
  this.curPlayer = this.p1;
  this.board = new Board();
};

Game.prototype.play = function(completionCallback) {
  var that = this;
  this.curPlayer.promptMove(that.board, function(move, mark) {
    var moveSuccess = that.board.placeMark(move, mark);
    if (moveSuccess) {
      that.curPlayer = that.curPlayer === that.p1 ? that.p2 : that.p1;
    } else {
      console.log("Invalid move");
    }
    
    that.board.print();
    
    if (that.board.isWon()) {
      console.log("Player " + that.board.winner() + " wins!");
      completionCallback();
    } else if (that.board.possibleMoves().length === 0){
      console.log("No one wins!");
      completionCallback();
    } else {
      that.play(completionCallback);
    }
  });
  
};

module.exports = Game;