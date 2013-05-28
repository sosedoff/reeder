angular.module('reeder.controllers', []).
  controller('IndexController', function IndexController($scope, $http) {
    $http.get('/api/feeds').success(function(data) {
      $scope.feeds       = data;
      $scope.feeds_count = data.length;

      $http.get('/api/posts').success(function(resp) {
        $scope.posts = resp;
      });
    });
  }).

  controller('FeedsController', function FeedsController($scope, $http) {
    $http.get("/api/feeds").success(function(resp) {
      $scope.feeds = resp;
    });
  }).

  controller('FeedController', function FeedController($scope, $http, $route, $routeParams) {
    var feed_id = $routeParams.feed_id;

    $("a.feed").removeClass('active');
    $("a.feed[data-id=" + feed_id + "]").addClass('active');

    $http.get("/api/feeds/" + feed_id).success(function(resp) {
      $scope.feed = resp;

      $http.get("/api/feeds/" + feed_id + "/posts").success(function(resp) {
        $scope.posts_count  = resp.total_entries;
        $scope.current_page = resp.page;
        $scope.posts        = resp.records;
      });
    });
  });