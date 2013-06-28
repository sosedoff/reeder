var modules = [
  'reeder.controllers', 
  'reeder.directives', 
  'reeder.helpers', 
  'ngSanitize', 
  'ngCookies'
];

angular.module('reeder', modules).
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

    $routeProvider.when('/signin', {
      templateUrl: '/views/signin.html',
      controller: 'SigninController'
    });

    $routeProvider.when('/signup', {
      templateUrl: '/views/signup.html',
      controller: 'SignupController'
    });

    $routeProvider.otherwise({redirectTo: '/'});
  }]);
