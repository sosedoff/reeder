'use strict';

var $httpBackend, ctrl, scope;

describe('reeder.sidebar.controllers', function() {
  describe('ReederSidebarController', function() {
    beforeEach(function() {
      module('reeder.sidebar.controllers');

      inject(function($controller, $rootScope, _$httpBackend_) {
        $httpBackend = _$httpBackend_;
        $httpBackend.when('GET', '/api/feeds/active').respond(['feed1', 'feed2', 'feed3']);

        scope = $rootScope.$new();
        ctrl = $controller('ReederSidebarController', {
          $rootScope: {}
        , $scope: scope
        });
      });
    });

    describe('isOk()', function() {
      it('returns true if feed.status is "ok"', function() {
        var feed = { status: 'ok' };
        expect(scope.isOk(feed)).toBe(true);
      });

      it('returns false if feed.status is not "ok"', function() {
        var feed = { status: 'not ok' };
        expect(scope.isOk(feed)).toBe(false);
      });
    });
  });
});

