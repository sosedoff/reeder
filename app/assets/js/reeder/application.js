var modules = [
  'reeder.controllers',
  'reeder.helpers',
  'reeder.feeds.factories',
  'reeder.sidebar',
  'reeder.signin',
  'reeder.signup',
  'ngSanitize',
  'ngCookies',
  'http-auth-interceptor'
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
  }]).

  run(['$http', '$rootScope', '$cookies', 'ReederFeed', function($http, $rootScope, $cookies, ReederFeed) {
    if ($cookies.api_token) {
      $http.defaults.headers.common['X-API-TOKEN'] = $cookies.api_token;
      $rootScope.feeds = ReederFeed.query({ order: 'modified' });
      $rootScope.authenticated = true;
    }

    $rootScope.$on('event:auth-loginRequired', function() {
      window.location = '/signin';
    });

    $rootScope.$on('event:auth-loginConfirmed', function() {
      $rootScope.authenticated = true;
      window.location = '/';
    });
  }]);

