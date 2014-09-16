window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
    this.router = new Journal.Routers.PostsRouter({
      $el: $("#journal-content")
    }); 
    // this.posts.fetch({
    //   success: function() {
    //     this.indexView.render();
    //     $('body').append(this.indexView.$el);
    //   }.bind(this)
    // });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
