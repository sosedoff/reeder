function matchAll(str, regex) {
  var matches = [];
  while (result = regex.exec(str)) {
    matches.push(result[1]);
  }
  return matches;
}

angular.module('reeder.helpers', []).
  filter('postDateFormatter', function() {
    return function(unformatted_date) {
      var date = new Date(unformatted_date);
      return moment(date).format('MMM Do, hh:mm a');
    };
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
  });