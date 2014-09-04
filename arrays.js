var myUniq = function(arr){
  var collect = [];
  for(var x = 0; x < arr.length; x++){
    if(collect.indexOf(arr[x]) === -1 ){
      collect.push(arr[x]);
    } 
  }
  return collect;
};


var twoSum = function(arr){
  var collect = [];
  for(var i = 0; i < arr.length; i++){
    for(var j = i; j < arr.length; j++){
      if ((i !== j ) && (arr[i] + arr[j] === 0)){
        collect.push( [i, j] );
      }
    }   
  }
  return collect;
};

var transpose = function(arr) {
  var transposed = [];
  for(var i = 0; i < arr.length; i++) {
    transposed.push(new Array(arr[i].length));
  }

  for(var i = 0; i < arr.length; i++) {
    for(var j = 0; j < arr[i].length; j++) {
        transposed[i][j] = arr[j][i];
        transposed[j][i] = arr[i][j];
    }
  }
  return transposed;
};

console.log( myUniq( [1, 1, 2]));
console.log( twoSum( [-1, 1, 0, 2, 0] ) );
console.log( transpose([[1, 2, 3], [4, 5, 6], [7, 8, 9]]));
