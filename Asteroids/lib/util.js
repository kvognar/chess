(function(){
  if (typeof Asteroids === "undefined" ){
    var Asteroids = window.Asteroids = {};
  }
  
  var Util = Asteroids.Util = {};
  
  //Asteroids.Util.inherits
  Util.inherits = function(parent, child) {
    var Surrogate = function (){};
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
  };
  
  Util.randomVec = function (min, max) {
    return [ min + Math.random() * max, min + Math.random() * max];
  };
  
})();

