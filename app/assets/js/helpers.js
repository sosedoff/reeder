angular.module('reeder.helpers', []).
  filter('postDateFormatter', function() {
    return function(unformatted_date) {
      var date = new Date(unformatted_date);
      return moment(date).format('dddd, h:m a');
    };
  });