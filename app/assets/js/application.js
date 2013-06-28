angular.module('reeder', ['reeder.controllers', 'reeder.directives', 'reeder.helpers', 'ngSanitize']).
  config(['$routeProvider', function($routeProvider) {
    
    $routeProvider.when('/', {
      templateUrl: '/views/feed.html', 
      controller: 'IndexController'
    });

    $routeProvider.when('/feeds', {
      templateUrl: '/views/feeds.html',
      controller: 'FeedsController'
    });

    $routeProvider.when('/feeds/:feed_id', {
      templateUrl: '/views/feed.html', 
      controller: 'FeedController'
    });

    $routeProvider.otherwise({redirectTo: '/'});
  }]);
