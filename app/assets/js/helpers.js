function matchAll(str, regex) {
  var matches = [];
  while (result = regex.exec(str)) {
    matches.push(result[1]);
  }
  return matches;
}

angular.module('reeder.helpers', []).
  config(function ($httpProvider) {
    $httpProvider.defaults.transformRequest = function(data) {  
      if (data === undefined) return data;
      return $.param(data);
    }

    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  });