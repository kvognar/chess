var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

Array.prototype.last = function () {
  return this[this.length - 1]; 
};

var HanoiGame = function () {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.prototype.isWon = function () {
  return ( this.stacks[1].length === 3 || this.stacks[2].length === 3 );
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (this.stacks[startTowerIdx].length > 0) {
    if ((this.stacks[endTowerIdx].length === 0) || 
        (this.stacks[startTowerIdx].last() < this.stacks[endTowerIdx].last())) {
        return true;
    } 
  }
  return false; 
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    var pieceToMove = this.stacks[startTowerIdx].pop();
    this.stacks[endTowerIdx].push(pieceToMove);
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Enter start tower", function (ans1) {
    reader.question("Enter end tower", function (ans2) {
      var startIdx = parseInt(ans1);
      var endIdx = parseInt(ans2);
      callback(startIdx, endIdx);
    });
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  var that = this;
  this.promptMove( function (startIdx, endIdx) {
    var successfulMove = that.move(startIdx, endIdx);
    if (!successfulMove) {
      console.log("Invalid move!");
    }
    console.log(that.isWon());
    if (!that.isWon()) {
      that.run(completionCallback);
    } else if (that.isWon()) {
      console.log("You win!");
      completionCallback();
    }
  });
};

var completionCallback = function () {
  reader.close();
};

var game = new HanoiGame();
game.run(completionCallback);