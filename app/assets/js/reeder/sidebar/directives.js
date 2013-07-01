'use strict';

angular.module('reeder.sidebar.directives', []).
  directive('reederSidebar', [function() {
    return {
      restrict: 'E',
      transclude: true,
      scope: {},
      controller: 'ReederSidebarController',
      templateUrl: '/views/sidebar.html',
      replace: true
    };
  }]);

