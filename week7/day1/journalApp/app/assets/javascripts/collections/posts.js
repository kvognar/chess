Journal.Collections.Posts = Backbone.Collection.extend({
  url: "api/posts",
  model: Journal.Models.Post,
  getOrFetch: function(id){
    var item = this.get(id);
    if(!item){
      item = new this.model({id: id});
      item.fetch();
    }
    return item;
  }
});

Journal.posts = new Journal.Collections.Posts();