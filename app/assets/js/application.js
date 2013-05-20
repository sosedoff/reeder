angular.module('reeder', ['reeder.controllers', 'ngSanitize']).
  config(['$routeProvider', function($routeProvider) {
    
    $routeProvider.when('/', {
      templateUrl: '/partials/feed.html', 
      controller: 'IndexController'
    });

    $routeProvider.when('/feeds/:feed_id', {
      templateUrl: '/partials/feed.html', 
      controller: 'FeedController'
    });

    $routeProvider.otherwise({redirectTo: '/'});
  }]);