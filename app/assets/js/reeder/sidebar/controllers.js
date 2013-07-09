'use strict';

angular.module('reeder.sidebar.controllers', []).
  controller('ReederSidebarController', [
    '$scope', '$http',
    function SidebarController($scope, $http) {
      $http.get('/api/feeds/active').success(function(data) {
        $scope.feeds       = data;
        $scope.feeds_count = data.length;
      });
    }
  ]);

