(function(){
  if (typeof Asteroids === "undefined" ){
    var Asteroids = window.Asteroids = {};
  }
  
  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
  };
  
  Game.NUM_ASTEROIDS = 30;
  Game.DIM_X = 800;
  Game.DIM_Y = 600;
  
  Game.randomPosition = function() {
    return [ Math.floor(Math.random() * Game.DIM_X ), 
             Math.floor(Math.random() * Game.DIM_Y ) ];
  };
  
  Game.addAsteroids = function() {
    
    while ( this.asteroids.length < Game.Game.NUM_ASTEROIDS){
      this.asteroids.push( new Asteroids.Asteroid(this.randomPosition));
    }
  };
  
  Game.draw = function(ctx){
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
    
    this.asteroids.forEach( function(asteroid){
      asteroid.draw();
    });
  };
  
  Game.moveObjects = function(){
    this.asteroids.forEach( function(asteroid){
      asteroid.move();
    });
  };
})();

