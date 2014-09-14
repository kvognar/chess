$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$charsLeft = this.$el.find(".chars-left");
  this.$textArea = this.$el.find('textarea');
  this.$feed = $(this.$el.data("tweets-ul"));
  this.$el.on('submit', this.submit.bind(this));
  this.$textArea.on("input", this.getRemainingChars.bind(this));
  this.$el.find("a.add-mentioned-user").on("click", this.addMentionedUser.bind(this));
  this.$el.find(".mentioned-users").on(
       "click", "a.remove-selector", this.removeMention.bind(this));
};

$.TweetCompose.prototype.submit = function(event) {
  event.preventDefault();
  var $inputs = $(":input");
  var jsonForm = $(event.currentTarget).serialize();
  $inputs.prop("disabled", true);
  $.ajax({
    method: "POST",
    url: "/tweets.json",
    data: jsonForm,
    success: function(rep){
      console.log("success");
      $inputs.prop("disabled", false);
      this.handleSuccess(rep);
    }.bind(this)
  });
};

$.TweetCompose.prototype.addMentionedUser = function() {
  var $scriptTag = $("#selector-template");
  var content = $scriptTag.html();
  $(".mentioned-users").append(content);
  
}

$.TweetCompose.prototype.clearInput = function () {
  $(".mentioned-users").empty();
  this.$textArea.val("");
}

$.TweetCompose.prototype.removeMention = function(event) {
  console.log(event);
  $(event.currentTarget).parent().remove();
}

$.TweetCompose.prototype.getRemainingChars = function () {
  this.$charsLeft.text(
      "Characters remaining: " + (140 - this.$textArea.val().length)
  );
};

$.TweetCompose.prototype.handleSuccess = function (response) {
  var tweet = JSON.stringify(response);
  var $tweet = $('<li>' + tweet + '</li>');
  this.$feed.append($tweet);
  this.clearInput();
};

$.fn.tweetCompose = function() {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};