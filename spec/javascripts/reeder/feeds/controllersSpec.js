'use strict';

var ctrl, scope, ReederFeed, $httpBackend;

describe('reeder.controllers', function() {
  describe('FeedsController', function() {
    beforeEach(function() {
      module('reeder.feeds.factories', 'reeder.controllers');

      inject(function($injector, _$httpBackend_, $controller, $rootScope) {
        $httpBackend = _$httpBackend_;
        $httpBackend.when('GET', '/api/feeds?order=modified').respond(['feed1', 'feed2', 'feed3']);
        scope = $rootScope.$new();
        ReederFeed = $injector.get('ReederFeed');
        ctrl = $controller('FeedsController', {
          $rootScope: {}
        , $scope: scope
        , ReederFeed: ReederFeed
        });
      });
    });

    it('gets feeds', function() {
      $httpBackend.flush();
      expect(scope.feeds.length).toBe(3);
    });

    describe('delete_feed()', function() {
      it('sends DELETE request', function() {
        $httpBackend.expectDELETE('/api/feeds/1').respond({ deleted: true });
        scope.delete_feed(1, 0);
        $httpBackend.flush();
      });

      it('removes feed from scope', function() {
        $httpBackend.when('DELETE', '/api/feeds/1').respond({ deleted: true });
        scope.delete_feed(1, 0);
        $httpBackend.flush();
        expect(scope.feeds.length).toBe(2);
      });
    });
  });
});

