'use strict';

var ctrl, scope, cookies;

describe('reeder.user.controllers', function() {
  describe('UserController', function() {
    beforeEach(function() {
      module('ngCookies', 'reeder.controllers');

      inject(function($injector, $controller, $rootScope) {
        scope = $rootScope.$new();
        cookies = $injector.get('$cookies');
        ctrl = $controller('UserController', {
          $rootScope: {}
        , $scope: scope
        , $cookies: cookies
        });
      });
    });

    describe('isAuthenticated()', function() {
      it('returns true if $cookies.api_token is a string', function() {
        cookies.api_token = 'foobar';
        expect(scope.isAuthenticated()).toBe(true);
      });

      it('returns false if $cookies.api_token is not a string', function() {
        cookies.api_token = null;
        expect(scope.isAuthenticated()).toBe(false);
      });
    });
  });
});

