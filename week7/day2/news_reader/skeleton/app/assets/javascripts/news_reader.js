window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    console.log("Backbone is running");
      
    new NewsReader.Routers.FeedRouter ({
      $content: $("#content"),
      $subview: $("#subview")
    });
    
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
