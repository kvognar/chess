Array.prototype.transpose = function () {
  var transposed = [];
    for (var i = 0; i < this.length; i++) {
      transposed.push(new Array(this[i].length));
    }

    for (var i = 0; i < this.length; i++) {
      for (var j = 0; j < this[i].length; j++) {
          transposed[i][j] = this[j][i];
          transposed[j][i] = this[i][j];
      }
    }
  return transposed;
};


var Board = function () {
  this.board = [new Array(3), new Array(3), new Array(3)];
  this.lastMoveMark = null;
};

Board.prototype.isWinningRow = function (row) {
  for (var i = 1; i < row.length; i++) {
    if ((row[i] !== row[i - 1]) || (row[i] === undefined)) {
      return false;
    }
    if (i === row.length - 1) {
      return true;
    }
  }
};

Board.prototype.allDirections = function () {
  var allDirections = this.board.slice();
  allDirections = allDirections.concat(this.board.transpose());
  allDirections = allDirections.concat(
    [[this.board[0][0], this.board[1][1], this.board[2][2]],
    [this.board[0][2], this.board[1][1], this.board[2][0]]]);
  return allDirections;
};

Board.prototype.isWon = function () {
  var directions = this.allDirections();
  for (var i = 0; i < directions.length; i++) {
    if (this.isWinningRow(directions[i])) {
      return true;
    }
  }
  return false;
};

Board.prototype.winner = function () {
  if (this.isWon()) {
    return this.lastMoveMark;
  } else {
    return null;
  }
};

Board.prototype.isEmpty = function (pos) {
  return !this.board[pos[0]][pos[1]];
};

Board.prototype.validMove = function (pos) {
  return ((pos[0] < this.board.length) && (pos[1] < this.board.length));
};

Board.prototype.placeMark = function (pos, mark) {
  if ((this.validMove(pos)) && (this.isEmpty(pos))) {
    this.board[pos[0]][pos[1]] = mark;
    this.lastMoveMark = mark;
    return true;
  } else {
    return false;
  }
};

Board.prototype.print = function () {
  for (var i = 0; i < this.board.length; i++) {
    console.log(this.board[i]);
  }
};

Board.prototype.dupBoard = function () {
  var dup = new Board();
  for (var i = 0; i < this.board.length; i++) {
    dup.board[i] = this.board[i].slice();
  }
  return dup;
};

Board.prototype.possibleMoves = function () {
  var possible = [];
  for (var i = 0; i < this.board.length; i++) {
    for (var j = 0; j < this.board.length; j++) {
      if (this.isEmpty([i, j])) {
        possible.push([i, j]);
      }
    }
  }
  return possible;
};

module.exports = Board;

// console.log([[1, 2, 3], [4, 5, 6], [7, 8, 9]].transpose());