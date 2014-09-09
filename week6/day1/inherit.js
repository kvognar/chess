Function.prototype.inherits = function(parent) {
  var Surrogate = function (){};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};


function MovingObject (color) {
  this.color = color;
}

MovingObject.prototype.getColor = function(){
  console.log(this.color);
};

function Ship (color) {
  // this.color = color;
  this.name = "Serenity";
  // this.constructor = Ship;
  MovingObject.apply(this, arguments)
  //MovingObject.call(this, color)
};
Ship.inherits(MovingObject);

function Asteroid (size) {
  this.size = size;
};
Asteroid.prototype.getSize = function(){
  console.log(this.size);
}
var movingObj = new MovingObject("blue");

var ship = new Ship("red");
ship.getColor();


Asteroid.inherits(MovingObject);
//ship.getSize();
// movingObj.getSize();
console.log(ship.name);
console.log(ship.constructor.name);