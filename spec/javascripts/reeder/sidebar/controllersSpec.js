'use strict';

describe('reeder.sidebar.controllers', function() {
  describe('ReederSidebarController', function() {
    var $httpBackend, ctrl, scope;

    beforeEach(module('reeder.sidebar.controllers'));
    beforeEach(function() {
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

