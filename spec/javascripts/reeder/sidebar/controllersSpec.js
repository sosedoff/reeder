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

    describe('addFeed()', function() {
      it('pushes new feed on `$scope.feeds`', function() {
        $httpBackend.flush();
        ctrl.addFeed('newFeed');
        expect(scope.feeds).toContain('newFeed');
      });

      it('increments `feeds_count`', function() {
        $httpBackend.flush();
        ctrl.addFeed('newFeed');
        expect(scope.feeds_count).toBe(4);
      });
    });

    describe('removeFeed()', function() {
      it('splices feed on `$scope.feeds`', function() {
        $httpBackend.flush();
        ctrl.removeFeed('feed2');
        expect(scope.feeds).not.toContain('feed2');
      });

      it('decrements `feeds_count`', function() {
        $httpBackend.flush();
        ctrl.removeFeed('feed2');
        expect(scope.feeds_count).toBe(2);
      });
    });
  });
});

