

var Human = function(mark, reader) {
  this.mark = mark;
  this.reader = reader;
};

Human.prototype.promptMove = function(board, callback) {
  var that = this;
  that.reader.question("Enter row #", function (ans1) {
    that.reader.question("Enter col#", function (ans2) {
      var row = parseInt(ans1);
      var col = parseInt(ans2);
      callback([row, col], that.mark);
    });
  });
};



module.exports = Human;