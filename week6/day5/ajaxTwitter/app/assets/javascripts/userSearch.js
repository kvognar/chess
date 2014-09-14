$.UserSearch = function (el) {
  this.$el = $(el);
  this.$ul = this.$el.find(".users");
  this.$searchBar = this.$el.find(".search-bar");
  this.$searchBar.on("input", this.handleInput.bind(this));
};

$.UserSearch.prototype.handleInput = function(event) {
  var query = $(event.currentTarget).val();
  $.ajax({
    method: "GET",
    url:"search.json",
    success: this.renderResults.bind(this),
    data: {
      query: query
    }
  });
};

$.UserSearch.prototype.renderResults = function (response) {
  var $ul = this.$ul;
  $ul.empty();
  response.forEach(function (user) {
    var options = {
      followState: user.followed ? "followed" : "unfollowed",
      userId: user.id
    };
    var $button = $("<button></button>").followToggle(options);
    var $userLi = $('<li><a href=/users/'+user.id+">" + user.username + '</a></li>');
    $userLi.append($button);
    $ul.append($userLi);
  });
  console.log(response);
};

$.fn.userSearch = function () {
  return this.each(function () {
    new $.UserSearch(this);
  });
};

