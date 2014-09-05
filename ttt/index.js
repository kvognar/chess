var Board = require("./board");
var Game = require("./game");
var Human = require("./human");
var Computer = require("./computer");

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var p1 = new Human('x', reader);
var p2 = new Computer('o');
var game = new Game(p1, p2);

var completionCallback = function() {
  reader.close();
};

game.play(completionCallback);