Function.prototype.myBind = function(context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};

var Dragon = function() {
  this.element = "fire";
};

var dragon = new Dragon();

var attack = function() { 
            console.log("beware " + this.element); 
          };

var dragonAttack = attack.myBind(dragon);

dragonAttack();