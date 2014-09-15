Journal.Collections.Posts = Backbone.Collection.extend({
  url: "api/posts",
  model: Journal.Models.Post
});

Journal.posts = new Journal.Collections.Posts();
Journal.posts.fetch();