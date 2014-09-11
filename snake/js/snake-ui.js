( function () {
  
  if (typeof window.SnakeGame === "undefined") {
    window.SnakeGame = {};
  }
  
  var UI = window.SnakeGame.UI = function (board, $map) {
    this.board = board;
    this.$map = $map;
    this.initialize();
  };
  
  UI.prototype.initialize = function () {
    
    var $rowsContainer = $('<div>');
    for (var i = 0; i < this.board.boardSize; i++) {
      var $row = $('<div>');
      $row.addClass('row');
      
      for (var j = 0; j < this.board.boardSize; j++) {
        var $cell = $('<div>');
        $cell.addClass('cell');
        $cell.data('cell', [i, j]);
        $cell.addClass('empty');
        $row.append($cell);
      }
      $rowsContainer.append($row);
    }
    this.$map.html($rowsContainer);
  }
    //
  // UI.prototype.render = function () {
  //   for( var i = 0; i < $map.children().length)
  // }
  
})();