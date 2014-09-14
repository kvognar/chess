$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "followed") {
    this.$el.text("Unfollow!");
    this.$el.prop("disabled", false);
  } else if (this.followState === "unfollowed") {
    this.$el.text("Follow!");
    this.$el.prop("disabled", false);
  } else {
    this.$el.text(this.followState);
    this.$el.prop("disabled", true);
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();

  var requestMethod;
  if (this.followState === "unfollowed") {
    requestMethod = "POST";
    this.followState = "following";
  } else {
    requestMethod = "DELETE";
    this.followState = "unfollowing";
  }
  this.render();
  
  var url = "/users/" + this.userId + "/follow.json";
 
  $.ajax({
    type: requestMethod,
    url: url,
    success: function () {
      this.followState = 
            this.followState === "unfollowing" ? "unfollowed" : "followed";
      this.render();
    }.bind(this),
    error: function () {
      console.log("f a i l u r e");
    },
    format: "json"
  });
      
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

// $(function() {
//   $("button.follow-toggle").followToggle();
// })