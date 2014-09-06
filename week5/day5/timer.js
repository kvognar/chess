var time = new Date();

var Clock = function() { 

};

Clock.TICK = 5000;

Clock.prototype.printTime = function() {
  console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

Clock.prototype.run = function() {
  this.seconds = time.getSeconds();
  this.minutes = time.getMinutes();
  this.hours = time.getHours();
  this.printTime();
  // console.log(Clock.TICK);
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function() {
  this.seconds += 5;
  if (this.seconds >= 60) {
    this.seconds = this.seconds % 60;
    this.minutes++;
  }
  if (this.minutes >= 60) {
    this.minutes = this.minutes % 60;
    this.hours ++;
  }
  if (this.hours >= 24) {
    this.hours = this.hours % 24;
  }
  this.printTime();
};

var clock = new Clock();
clock.run();