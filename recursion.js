var range = function(start, end){
  if (start === end){
    return [end];
  }
  return range(start, end -1 ).concat([end]);
};

// console.log(range(1,10));

var expo = function(b, n){
  if (n === 0){
   return 1; 
  }
  return b * expo(b, n-1);
};

var expoFast = function(b, n){
  if(n === 0) {
    return 1;
  }
  if(n === 1) {
    return b;
  }
  if(n % 2 === 0){
    var temp = expoFast(b, n/2);
    return (temp * temp);
  }
  if(n % 2 === 1){
    var temp = expoFast(b, (n-1)/2);
    return (temp * temp) * 2;
  }
};

// console.log(expo(2,3));
// console.log(expoFast(2,3));


var fibonacci = function(n){
  if(n === 0) {
    return [];
  }
  if(n === 1) {
    return [0];
  }
  if(n === 2) {
    return [0, 1];
  }
  var prevFibs = fibonacci(n-1);
  return prevFibs.concat([prevFibs[prevFibs.length-1] +
                          prevFibs[prevFibs.length-2]]);
};

// console.log(fibonacci(10));

var binarySearch = function(arr, target, min, max) {
  if (max < min) {
    return false;
  }
  else {
    var middle = Math.floor((max + min) / 2);
    if (arr[middle] > target) {
      return binarySearch(arr, target, min, middle-1);
    }
    else if (arr[middle] < target) {
      return binarySearch(arr, target, middle+1, max);
    }
    else {
      return middle;
    }
  }
};

var temparr = [2, 3, 4, 5, 6, 8];
// console.log(binarySearch(temparr, 7, 0, temparr.length));

var makeChangeHelper = function(target, coins){
  if (coins.length === 0){return [];}
  var currentCoin = coins.shift();
  var numCoin = 0;
  var coinCollect = [];
  numCoin = Math.floor(target / currentCoin);
  for ( var i = 0; i < numCoin; i++) {
    coinCollect.push(currentCoin);
  }
  var remainingAmount = target - numCoin * currentCoin;
  return coinCollect.concat(makeChange(remainingAmount, coins));
};

var makeChange = function(target, coins) {
  var coinOrder = coins.slice(0);
  var currentCombo = makeChangeHelper(target, coinOrder);
  for( var i = 1; i < coins.length; i++){
    coinOrder = coins.slice(i);
    var temp = makeChangeHelper(target, coinOrder); 
    
    if (temp.length < currentCombo.length && temp.length !== 0 ){
      currentCombo = temp;
    } 
  }
  return currentCombo;
};

// console.log(makeChange(39, [25,10, 5,1]));

var mergeSort = function(arr){
  if(arr.length <= 1){ return arr; }
  var middle = Math.floor(arr.length/2);
  var left = mergeSort(arr.slice(0, middle));
  var right = mergeSort(arr.slice(middle));
  return merge(left, right);
};

var merge = function(left, right){
  var mergedArray = [];
  while(left.length !== 0 && right.length !== 0){
    if (left[0] < right[0]){
      mergedArray.push(left.shift());
    } else {
      mergedArray.push(right.shift());
    }  
  }
  mergedArray = mergedArray.concat(left).concat(right);
  return mergedArray;
  
};
//
// console.log(merge([1, 4], [2,3, 4]));
// console.log(mergeSort([10, 9, 8, 7, 6, 5, 4]));

//
var subSets = function(arr){
  if(arr.length === 0) {
    return [[]];
  }
  var heldVar = arr.pop();
  var subs = subSets(arr);
  var allSubs = subs.slice(0);
  for(var i = 0; i < subs.length; i++) {
    var temp = subs[i].slice(0);
    temp.push(heldVar);
    allSubs.push(temp);
  }
  return allSubs;
  
};

console.log(subSets([1,2,3]));