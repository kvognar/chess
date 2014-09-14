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
    success: function(tweets) {
      if($(tweets).length > 0){
        var template = $("#feed-template").html();
        var result = _.template(template);
        result = result({tweets:tweets});
        console.log($(result).html());
        $("#feed").append(result);
        this.maxCreatedAt = $(tweets).last().attr("created_at");
        
        if( $(tweets).length < 10) {
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