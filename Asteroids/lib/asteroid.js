(function () {
  
  if (typeof Asteroids === "undefined") {
    var Asteroids = window.Asteroids = {};
  }
  
  var Asteroid = Asteroids.Asteroid = function (pos) {
    Asteroids.MovingObject.call(this,  {
      color: Asteroid.COLOR,
      radius: Asteroid.RADIUS,
      pos: pos,
      vel: Asteroids.Util.randomVec()
    });
  };
  
  Asteroid.COLOR = "white";
  Asteroid.RADIUS = 10;
  
})();