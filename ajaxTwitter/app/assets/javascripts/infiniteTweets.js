$.infiniteTweets = function(el, options) {
  this.$el = $(el);
  this.$el.on("click", this.fetchTweets).bind(this);
  this.maxCreatedAt = null;
};

$.infiniteTweets.prototype.fetchTweets = function() {
  $.ajax({
    method: "GET",
    url:"/feed",
    dataType: "json",
    success: function(tweet) {
      $("#feed").append("<li>"+JSON.stringify(tweet)+ "</li>");
    },
    data: this.maxCreatedAt
  });
};


$.fn.infiniteTweets = function(options) {
  this.each(function(){
    new $.infiniteTweets(this, options);
  });
};