var modules = [
  'reeder.controllers',
  'reeder.helpers',
  'reeder.sidebar',
  'reeder.signin',
  'reeder.signup',
  'ngSanitize',
  'ngCookies'
];

angular.module('reeder', modules).
  config(['$routeProvider', function($routeProvider) {

    $routeProvider.when('/', {
      templateUrl: '/views/feed.html',
      controller: 'IndexController'
    });

    $routeProvider.when('/recent', {
      templateUrl: '/views/feed.html',
      controller: 'IndexController'
    });

    $routeProvider.when('/bookmarks', {
      templateUrl: '/views/feed.html',
      controller: 'BookmarkedPostsController'
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

