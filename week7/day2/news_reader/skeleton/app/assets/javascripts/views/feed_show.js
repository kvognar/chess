NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],
  
  initialize: function () {
    this.listenTo(this.model, 'sync add delete', this.render);
  },
  
  render: function () {
    var renderContent = this.template({ feed: this.model });
    this.$el.html(renderContent);
    
    return this;
  }
  
});