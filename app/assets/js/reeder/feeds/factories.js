'use strict';

angular.module('reeder.feeds.factories', ['ngResource']).
  factory('ReederFeed', ['$resource', function($resource) {
    var ReederFeed = $resource('/api/feeds/:id');
    return ReederFeed;
  }]);

