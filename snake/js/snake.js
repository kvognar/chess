( function () {
  
  if (typeof window.SnakeGame === "undefined") {
    window.SnakeGame = {};
  }
  
  var DIR = {
    "a": [-1, 0],
    "w": [0, -1],
    "d": [0, 1],
    "s": [1, 0]
  };
  
  var Snake = window.SnakeGame.Snake = function (segments) {
    this.segments = segments;
    this.dir = "w";
  };
  
  Snake.prototype.move = function (eating) {
    var newSegment = [this.segments[0] + DIR[this.dir][0],
                      this.segments[1] + DIR[this.dir][1]];
    this.segments.unshift(newSegment);
    if (!eating) {
      this.segments.pop();
    }
    
  };
  
  Snake.prototype.turn = function(dir) {
    this.dir = dir;
  };
  
  
  var Board = window.SnakeGame.Board = function (boardSize) {
    var middle = Math.floor(boardSize/2);
    var seg1 = [middle, middle];
    var seg2 = [middle, middle+1];
    var seg3 = [middle, middle+2];
    this.snake = new Snake([seg1, seg2, seg3]);
    this.boardSize = boardSize;
  };
  
})();