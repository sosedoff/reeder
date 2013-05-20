angular.module('reeder.controllers', []).
  controller('IndexController', function IndexController($scope, $http) {
    $http.get('/api/feeds').success(function(data) {
      $scope.feeds       = data;
      $scope.feeds_count = data.length;
    });
  }).
  controller('FeedController', function FeedController($scope, $http, $route, $routeParams) {
    var feed_id = $routeParams.feed_id;

    $http.get("/api/feeds/" + feed_id).success(function(resp) {
      $scope.feed = resp;

      $http.get("/api/feeds/" + feed_id + "/posts").success(function(resp) {
        $scope.posts = resp;
      });
    });
  });