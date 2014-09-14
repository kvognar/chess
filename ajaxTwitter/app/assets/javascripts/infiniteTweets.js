$.infiniteTweets = function(el, options) {
  this.$el = $(el);
  this.$el.on("click", this.fetchTweets).bind(this);
  this.maxCreatedAt = null;
};


$.infiniteTweets.prototype.fetchTweets = function() {
    function removeGetTweets() {
     $(".fetch-more").remove();
     $("#feed").append("<p>There are no more tweets!</p>");
  } 
  $.ajax({
    method: "GET",
    url:"/feed",
    dataType: "json",
    success: function(tweet) {
      if($(tweet).length > 0){
      
        $("#feed").append("<li>"+JSON.stringify(tweet)+ "</li>");
        this.maxCreatedAt = $(tweet).last().attr("created_at");
      
        if( $(tweet).length < 10) {
          removeGetTweets();
        }
      } else {
        removeGetTweets();
      }
    }.bind(this),
    data: {"max_created_at":this.maxCreatedAt}
  });
};



$.fn.infiniteTweets = function(options) {
  this.each(function(){
    new $.infiniteTweets(this, options);
  });
};