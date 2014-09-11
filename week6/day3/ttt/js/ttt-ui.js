(function () {
  
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }
  
  var TTTUI = window.TTT.UI = function (game, $board) {
    this.game = game;
    this.$board = $board;
    this.initialize();
  };
  
  
  TTTUI.prototype.initialize = function () {
    var ui = this;
    for(var i = 0; i < 3; i++) {
      var $row = $("<div></div>");
      $row.attr("class", "row");
      for(var j = 0; j < 3; j++) {
        var $cell = $("<div></div>");
        $cell.attr("class", "cell");
        $cell.data("cell", [i, j]);
        $cell.on("click", ui.tryMark.bind(ui));
        $row.append($cell);
      }
      this.$board.append($row);
    }
  };
  
  TTTUI.prototype.tryMark = function (event) {
    var $cell = $(event.currentTarget);
    var move = $cell.data().cell;
    try {
      var currentPlayer = this.game.currentPlayer;
      this.game.playMove(move);
      $cell.addClass(currentPlayer);
      var $mark = $("<p></p>");
      $mark.text(currentPlayer);
      $cell.append($mark);
    } catch(e) {
      console.log(e.msg);
    }
    
    if (this.game.isOver()) {
      var $winner = $("<div></div>").text(this.game.winner() + " wins!");
      $winner.attr("class", "winner-message");
      this.$board.append($winner);
      $('.cell').off("click");
    }
  };
  
})();