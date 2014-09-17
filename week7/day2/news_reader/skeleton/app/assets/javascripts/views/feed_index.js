NewsReader.Views.FeedIndex = Backbone.View.extend({
  
  template: JST['feeds/index'],
  formTemplate: JST['feeds/new'],
  
  initialize: function(){
    this.listenTo(this.collection, 'sync add remove', this.render);
  },
  
  render: function () {
    var renderContent = this.template({ feeds: this.collection });
    this.$el.html(renderContent);
    
    return this;
  },
  
  events: {
    'click button.btn-refresh': 'refresh',
    'click button.btn-delete': 'destroy',
    "click button.btn-new-feed": "newForm",
    "submit form.new-feed-form": "create",
  },
  
  newForm: function () {
    var $form = $(this.$el.find(".new-form-container"));
    $form.find(".btn-new-feed").remove();
    $form.html(this.formTemplate());
  },
  
  removeForm: function ($form) {
    $form.remove();
    var $newButton = $("<button class='btn-new-feed'>");
    $newButton.text("New Feed");
    $(".new-form-container").append($newButton);
  },
  
  create: function(event) {
    event.preventDefault();
    var $form = $(event.currentTarget)
    var that = this;
    var newFeed = new NewsReader.Models.Feed({
      url: $form.find('.form-url').val()
    });
    newFeed.save({}, {
      success: function (){
        that.collection.add(newFeed);
        that.removeForm($form);
      }
    });
  },
  
  destroy: function (event) {
    var id = $(event.currentTarget).data('id');
    var feed = this.collection.get(id);
    feed.destroy();
  },

  refresh: function () {
    this.collection.fetch();
  }
  
});