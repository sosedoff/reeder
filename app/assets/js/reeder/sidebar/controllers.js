'use strict';

angular.module('reeder.sidebar.controllers', []).
  controller('ReederSidebarController', [
    '$scope', '$http', '$cookies',
    function SidebarController($scope, $http, $cookies) {
      $http.get('/api/feeds/active?api_token=' + $cookies.api_token).success(function(data) {
        $scope.feeds       = data;
        $scope.feeds_count = data.length;
      });
    }
  ]);

