var bubbleSort = function(arr) {
  //bang!
  var swapped = true;
  
  while(swapped) {
    swapped = false;
    for(var i = 0; i < arr.length -1; i++ ) {
      if (arr[i] > arr[i + 1]) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        swapped = true;
      }
    }
  }
  return arr;
};

var a = [3, 2, 1];
console.log(bubbleSort(a));
console.log(a);

var substrings = function(string) {
  var subs = [];
  
  for (var i = 0; i <= string.length -1; i++) {
    for (var j = i + 1; j <= string.length; j++) {
      subs.push(string.substring(i, j));
    }
  }
  return subs;
};

console.log(substrings("cat"));