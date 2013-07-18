'use strict';

angular.module('reeder.sidebar.controllers', []).
  controller('ReederSidebarController', ['$scope', '$http', function SidebarController($scope, $http) {
    var self = this;

    self.addFeed = function(feed) {
      $scope.feeds.push(feed);
      $scope.feeds_count++;
    };

    self.removeFeed = function(feed) {
      $scope.feeds.splice($scope.feeds.indexOf(feed), 1);
      $scope.feeds_count--;
    };

    $http.get('/api/feeds/active').success(function(data) {
      $scope.feeds       = data;
      $scope.feeds_count = data.length;
    });

    $scope.$on('feedCreated', function(event, feed) { self.addFeed(feed); });
    $scope.$on('feedDestroyed', function(event, feed) { self.removeFeed(feed); });
  }]);

