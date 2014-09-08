(function(){
  if (typeof Asteroids === "undefined" ){
    Asteroids = {};
  }
  
  var GameView = Asteroids.GameView = function(game, ctx){
    this.game = game;
    this.ctx = ctx;
  };
  
  GameView.prototype.start = function () {
    this.bindKeyHandlers();
    // this.game.addAsteroids();
    setInterval(function () {
      this.game.moveObjects();
      this.game.draw(this.ctx);
    }, 20);
  };
  
  GameView.prototype.bindKeyHandlers = function() {
    var game = this.game
    key('up', function(){ game.ship.power([0,-1])});
    key('down', function(){ game.ship.power([0, 1])});
    key('right', function(){ game.ship.power([1,0])});
    key('left', function(){ game.ship.power([-1, 0])});
    key('space', function() { game.ship.fireBullet()});
  };
  
})();