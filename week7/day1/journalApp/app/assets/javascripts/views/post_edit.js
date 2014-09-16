Journal.Views.PostEdit = Backbone.View.extend({
  template: JST['posts/edit'],
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
  },
  render: function(){
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },
  
  editPost: function(event){
    event.preventDefault();
    var form = $(event.currentTarget).serialize();
    debugger;
    // var post = this.collection.get($form.data("id"));
    this.model.set(form);
    this.model.save();
  },
  
  events: {
    'submit .edit': 'editPost'
  }
});