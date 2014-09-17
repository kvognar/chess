NewsReader.Routers.FeedRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "feeds/:id": "show"
  },
  
  initialize: function (options) {
    this.$content = options.$content;
    this.$subview = options.$subview;
  },
  
  index: function () {
    var feedCollection = NewsReader.feeds;
    feedCollection.fetch();
    var indexView = new NewsReader.Views.FeedIndex({
      collection: feedCollection
    });
    
    this.$subview.html("");
    this.$content.html(indexView.render().$el);
  },
  
  show: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    feed.fetch();
    var showView = new NewsReader.Views.FeedShow({
      model: feed
    });
    this._swapView(showView);
  },
  
  _swapView: function (view) {
    if (this._currentView) {
      this._currentView.remove();
    }
    this.$subview.html(view.render().$el);
    this._currentView = view;
  }
});