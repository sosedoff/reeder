'use strict';

angular.module('reeder.sidebar.controllers', []).
  controller('ReederSidebarController', ['$rootScope', '$scope', '$http', function SidebarController($rootScope, $scope, $http) {
    $scope.feeds = $rootScope.feeds;

    $scope.isOk = function(feed) {
      return angular.equals(feed.status, 'ok');
    };
  }]);

