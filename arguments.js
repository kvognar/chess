function sum() {
  var args = Array.prototype.slice.call(arguments);
  var sum = 0;
  for ( var i = 0; i < args.length; i++){
    sum += args[i];
  }
  return sum;
}
console.log(sum(1, 2, 3, 4));

Function.prototype.myBind = function(obj){
 var args = Array.prototype.slice.call(arguments, 1);
 var fn =this;
 
 return function(){
   var my_arguments = Array.prototype.slice.call(arguments);
   return fn.call(obj, args.concat(my_arguments));
 }
  
};

var myObj = {}
var printNums = function () {
  console.log(arguments);
};
var myBoundFunction = printNums.myBind(myObj, 1, 2)

// equivalent to `obj.myFunction(1, 2, 3)`
myBoundFunction(3);

var curriedSum = function (numArgs) {
  var numbers = [];
  
  var _curriedSum = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      var sum = 0;
      for (var i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      }
      return sum;
    } else {
      return _curriedSum;
    } 
  }
  return _curriedSum;
}

console.log(curriedSum(3)(1)(2)(3));

Function.prototype.curry = function(numArgs) {
  var args = [];
  
  var fn = this;
  
  var _curriedFunction = function (arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return fn.apply({}, args);
    } else {
      return _curriedFunction;
    }
  }
  return _curriedFunction;
};

logCurry = console.log.curry(5);
logCurry(1)(2)(3)(4)(5);