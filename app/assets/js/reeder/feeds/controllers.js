angular.module('reeder.controllers', []).
  controller('IndexController', function IndexController($scope, $cookies, $http) {
    var url = "/api/posts";

    $http.get(url).success(function(resp) {
      $scope.page        = resp.page;
      $scope.total_pages = resp.total_pages;
      $scope.posts       = resp.records;
    });
  }).

  controller('BookmarkedPostsController', function BookmarkedPostsController($scope, $cookies, $http) {
    var url = "/api/posts?bookmarked=true";

    $http.get(url).success(function(resp) {
      $scope.page        = resp.page;
      $scope.total_pages = resp.total_pages;
      $scope.posts       = resp.records;
    });
  }).

  controller('SearchController', function SearchController($scope, $cookies, $http) {
    $scope.search_posts = function() {
      var url = "/api/posts/search";
      url += "&query=" + $scope.search_query;

      $http.get(url).success(function(resp) {
        $scope.page        = resp.page;
        $scope.total_pages = resp.total_pages;
        $scope.posts       = resp.records;
      });
    }
  }).

  controller('FeedsController', ['$scope', 'ReederFeed', function FeedsController($scope, ReederFeed) {
    $scope.delete_feed = function(id, index) {
      ReederFeed.delete({ id: id }, function(response) {
        if (response.deleted) $scope.feeds.splice(index, 1);
      });
    };

    $scope.feeds = ReederFeed.query({ order: 'modified' });
  }]).

  controller('FeedController', ['$scope', '$http', '$route', '$cookies', '$routeParams', 'ReederFeed', function FeedController($scope, $http, $route, $cookies, $routeParams, ReederFeed) {
    var feed_id = $routeParams.feed_id;

    $scope.feed = ReederFeed.get({ id: feed_id }, function() {
      $http.get("/api/feeds/" + feed_id + "/posts").success(function(resp) {
        $scope.posts_count  = resp.total_entries;
        $scope.current_page = resp.page;
        $scope.posts        = resp.records;
      });
    });

    $("a.feed").removeClass('active');
    $("a.feed[data-id=" + feed_id + "]").addClass('active');
  }]).

  controller('FeedImportController', function FeedImportController($scope, $cookies, $http) {
    $scope.import_feed = function() {
      var url = prompt('Enter feed URL');
      var params = { url: url };

      $http.post("/api/feeds/import", params).
        success(function(data, status) {
          console.log(data);
        });
    }
  }).

  controller('FeedNavigationController', function FeedNavigationController($scope, $http) {
    $scope.view_full = function() {
      $("#main").removeClass('condensed');
      $("#view_full").addClass('active');
      $("#view_condensed").removeClass('active');
    }

    $scope.view_condensed = function() {
      $("#main").addClass('condensed');
      $("#view_condensed").addClass('active');
      $("#view_full").removeClass('active');
    }
  }).

  controller('PostController', function PostController($scope, $cookies,$http) {
    $scope.bookmark = function(post_id) {
      $scope.post_id = post_id;
      var url = "/api/posts/" + post_id + "/bookmark";

      $http.post(url).
        success(function(data, status) {
          $("#star_" + $scope.post_id).addClass('active');
          alert('Post has been bookmarked');
        });
    };
  }).

  controller('UserController', ['$scope', '$location', '$cookies', function UserController($scope, $location, $cookies) {
    $scope.isAuthenticated = function() {
      return angular.isString($cookies.api_token);
    };

    $scope.signout = function() {
      delete $cookies.api_token;
      window.location = '/';
    };
  }]);

