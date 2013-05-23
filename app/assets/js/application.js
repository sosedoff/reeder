angular.module('reeder', ['reeder.controllers', 'reeder.helpers', 'ngSanitize']).
  config(['$routeProvider', function($routeProvider) {
    
    $routeProvider.when('/', {
      templateUrl: '/partials/feed.html', 
      controller: 'IndexController'
    });

    $routeProvider.when('/feeds', {
      templateUrl: '/partials/feeds.html',
      controller: 'FeedsController'
    });

    $routeProvider.when('/feeds/:feed_id', {
      templateUrl: '/partials/feed.html', 
      controller: 'FeedController'
    });

    $routeProvider.otherwise({redirectTo: '/'});
  }]);