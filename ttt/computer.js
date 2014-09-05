

var Computer = function(mark) {
  this.mark = mark;
};

Computer.prototype.promptMove = function(board, callback) {
  var possibleMoves = board.possibleMoves();

  var nextMove = null;
  for (var i = 0; i < possibleMoves.length; i++) {
    var dup = board.dupBoard();

    dup.placeMark(possibleMoves[i], this.mark);
    if (dup.isWon()) {
      nextMove = possibleMoves[i];
    }
  }
  nextMove = nextMove || this.randomMove(possibleMoves);

  callback(nextMove, this.mark);
    
};

Computer.prototype.randomMove = function (possibleMoves) {
  return possibleMoves[Math.floor(Math.random() * possibleMoves.length)];
}; 



module.exports = Computer;