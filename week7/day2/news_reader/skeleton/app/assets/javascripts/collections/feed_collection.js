NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: "/api/feeds",
  initialize: function(){
    console.log('new collection');
  },
  
  getOrFetch: function (id) {
    var feed = this.get(id);
    
    if (!feed) {
      feed = new NewsReader.Models.Feed ({ id: id });
      // this.add(feed);
      feed.fetch({
        success: function () { this.add(feed) }.bind(this)
      });
    }
    
    return feed;
  }
});

NewsReader.feeds = new NewsReader.Collections.Feeds ();