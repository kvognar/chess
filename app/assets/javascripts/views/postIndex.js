Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],
  initialize: function (options) {
    this.listenTo(this.collection, 
                  'remove change:title add reset', 
                  this.render
    );
  },
  render: function(){
    var content = this.template({posts: this.collection});
    this.$el.html(content);
    return this;
  },
  
  deletePost: function(event){
    var $button = $(event.currentTarget);
    this.collection.get($button.data("id")).destroy();
  },
 
  
  
  events: {
    'click button.remove-post': 'deletePost'
  }
});

Journal.indexView = new Journal.Views.PostsIndex({
  collection: Journal.posts
});


// $('body').append(indexView.$el);

// indexView.fetch({
//   success: function(event){
//     $
//   }
// })