const FollowToggle = require('./follow_toggle.js');

$(function () {
  // $('div.infinite-tweets').each( (idx, tweet) => new InfiniteTweets(tweet) );
  $('button.follow-toggle').each( (idx, btn) => new FollowToggle(btn, {}) );

})
