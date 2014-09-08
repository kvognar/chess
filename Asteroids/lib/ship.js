(function(){
  if (typeof Asteroids === "undefined" ){
    Asteroids = {};
  }
 
  
  var Ship = Asteroids.Ship = function(game){
    Asteroids.MovingObject.call(this, {
      radius: Ship.RADIUS,
      color: Ship.COLOR,
      pos: game.randomPosition(),
      vel: [0, 0],
      game: game
    })
  };
  
  
  Ship.RADIUS = 10;
  Ship.COLOR = "blue";
  
  Asteroids.Util.inherits(Asteroids.MovingObject, Ship);
 
  Ship.prototype.relocate = function () {
    this.pos = game.randomPosition();
    this.vel = [0, 0];
  };
  
  Ship.prototype.power = function (impulse) {
    console.log(this.vel);
    
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };
  
  Ship.prototype.fireBullet = function () {
    bullet = new Asteroids.Bullet(this.game);
  }
  
})();