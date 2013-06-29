function matchAll(str, regex) {
  var matches = [];
  while (result = regex.exec(str)) {
    matches.push(result[1]);
  }
  return matches;
}

function formatAuthorName(name) {
  if (name) {
    return "by <a href='#'>" + name + "</a>";
  }
  else {
    return "";
  }
}

angular.module('reeder.helpers', []).
  filter('postDateFormatter', function() {
    return function(unformatted_date) {
      var date = new Date(unformatted_date);
      return moment(date).format('MMM Do, YYYY');
    };
  }).

  filter('postSanitizer', function($sanitize) {
    return function(text) {
      return $sanitize(text);
    }
  }).

  filter('postBookmarkClass', function() {
    return function(post) {
      return post.bookmarked ? 'active' : '';
    }
  }).

  filter('postAuthorFormatter', function() {
    return function(post) {
      return formatAuthorName(post.author);
    }
  }).

  filter('postFormatter', function() {
    return function(post) {
      var content = post.content;
      var regex   = /<img.*?src=['|"](.*?)['|"]/gi;
      var matches = matchAll(content, regex);

      if (matches.length > 0) {
        for (i in matches) {
          var url = matches[i];

          if (!url.match(/^http(s?):/)) {
            var new_url = post.feed.site_url;

            if (url.substring(0, 2) != '//') {
              if (url[0] == '/') new_url += url;
              else new_url += '/' + url;
          
              content = content.replace(url, new_url);
            }
          }
        }
      }

      return content;
    }
  }).

  config(function ($httpProvider) {
    $httpProvider.defaults.transformRequest = function(data) {  
      if (data === undefined) return data;
      return $.param(data);
    }

    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  });