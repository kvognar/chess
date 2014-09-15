window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
    this.posts.fetch({
      success: function() {
        this.indexView.render();
        $('body').append(this.indexView.$el);
      }.bind(this)
    });
  }
};

$(document).ready(function(){
  Journal.initialize();
});
