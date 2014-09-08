(function(){
  if (typeof Asteroids === "undefined" ){
    Asteroids = {};
  }
  
  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
    this.addShip();
  };
  
  Game.NUM_ASTEROIDS = 10;
  Game.DIM_X = 800;
  Game.DIM_Y = 600;
  
  Game.prototype.randomPosition = function() {
    return [ Math.floor(Math.random() * Game.DIM_X ), 
             Math.floor(Math.random() * Game.DIM_Y ) ];
  };
  
  Game.prototype.addShip = function () {
    this.ship = new Asteroids.Ship(this);
  }
  
  Game.prototype.addAsteroids = function() {
    
    while ( this.asteroids.length < Game.NUM_ASTEROIDS){
      var asteroid = new Asteroids.Asteroid(this);
      this.asteroids.push(asteroid);
    }
  };
  
  Game.prototype.draw = function(ctx){
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
    
    this.asteroids.forEach( function(asteroid){
      asteroid.draw(ctx);
    });
    this.ship.draw(ctx);
  };
  
  Game.prototype.moveObjects = function(){
    this.asteroids.forEach( function(asteroid){
      asteroid.move();
    });
    this.ship.move();
    this.checkCollisions();
    
  };
  
  Game.prototype.wrap = function(pos) {
    var newPos = [];
    newPos[0] =(pos[0] + Game.DIM_X) % Game.DIM_X;
    newPos[1] = (pos[1] + Game.DIM_Y) % Game.DIM_Y;
    return newPos;
  }
  
  Game.prototype.checkCollisions = function () {
    var game = this;
    this.allObjects().forEach( function(obj1) {
      game.allObjects().forEach ( function(obj2) {
        if (obj1 !== obj2) {
          if (obj1.isCollidedWith(obj2)) {
            obj1.collideWith(obj2);
          }
        }
      })
    })
  }
  
  Game.prototype.allObjects = function () {
    return this.asteroids.slice().concat([this.ship]);
  }
  
  Game.prototype.remove = function (asteroid) {
    if (this.asteroids.indexOf(asteroid) !== -1){
      this.asteroids.splice(this.asteroids.indexOf(asteroid), 1);
    }
  }
  
  
  
})();

