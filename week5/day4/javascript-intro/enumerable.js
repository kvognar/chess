var double = function(arr) {
  var collect = [];
  for (var i = 0; i < arr.length; i++) {
    collect.push(arr[i]*2);
  }
  return collect;
};

console.log(double([1,2,3]));

Array.prototype.myEach = function(func){
  for(var i = 0; i < this.length; i++){
    func(this[i] );
  }
};

var doubley = function(el) {
  return (el * 2);
};

console.log( [1,2,3].myEach(doubley ) );

Array.prototype.myMap = function(func){
  var collect = [];
  var newFunc = function(el){
    collect.push(func(el));   
  };
  this.myEach( newFunc );
  return collect;
};

console.log([1,2,3].myMap(doubley) );

Array.prototype.myInject = function(func){
  var val = this[0];
  var newFunc = function(el){
    val = func(val, el);   
  };
  this.slice(1).myEach( newFunc );
  return val;
};

var sum = function(x, y) {
  return x + y;
};

console.log([1,2,3].myInject(sum) );