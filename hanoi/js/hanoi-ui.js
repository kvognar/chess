( function () {
  
  if (typeof window.Hanoi === "undefined") {
    window.Hanoi = {};
  }
  
  var UI = window.Hanoi.UI = function (game, $towers) {
    this.game = game;
    this.$towers = $towers;
    this.render();
    this.chosenTower = null;
    this.$towers.on('click', '.tower',  this.moveTower.bind(this));
  };
    
  UI.prototype.moveTower = function (event) {
    if (this.chosenTower === null) {
      var $targetTower = $(event.currentTarget);
      this.chosenTower = $targetTower.data("id");
      $targetTower.addClass("selected");
      //show selected tower
    } else {
      var endTower = $(event.currentTarget).data("id");
      this.game.move(this.chosenTower, endTower);
      this.chosenTower = null;
      this.render();
      this.checkForWin();
    }
    

  };

  UI.prototype.checkForWin = function () {
    if (this.game.isWon()) {
      alert("Huzzah!");
      $('.tower').off('click');
    }
  };

  UI.prototype.render = function () {
    this.$towers.children().remove();
    var $towersContainer = $('<div>');
    
    for(var i = 0; i < 3; i++) {
      var $tower = $('<div>');
      $tower.addClass("tower");
      $tower.data("id", i);
      // $newTowers.append($tower);
      for(var j = 0; j < this.game.towers[i].length; j++) {
        var $disk = $('<div>');
        $disk.addClass("disk");
        $disk.addClass("size-" + this.game.towers[i][j]);
        $tower.append($disk);
      }
      // this.$towers.append($tower);
      $towersContainer.append($tower);
    }
    this.$towers.html($towersContainer);
   
  };
  
})();