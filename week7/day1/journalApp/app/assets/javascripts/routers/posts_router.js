Journal.Routers.PostsRouter = Backbone.Router.extend({
  
  initialize: function(options){
    this.$el = options.$el;
  },
  
  routes: {
    "": 'index',
    "posts/:id": 'show', 
    "posts/:id/edit": 'edit'
  },
  
  index: function () {
    var view = new Journal.Views.PostsIndex({
      collection: Journal.posts
    });
    
    Journal.posts.fetch();
    this.$el.html(view.render().$el);
  },
  
  show: function (id) {
    var view = new Journal.Views.PostShow({ 
      model: Journal.posts.getOrFetch(id) 
    });
    this.$el.html(view.render().$el);
  },
  
  edit: function(id){
    var view = new Journal.Views.PostEdit({
      model: Journal.posts.getOrFetch(id)
    });
    this.$el.html(view.render().$el);
  },
  
});