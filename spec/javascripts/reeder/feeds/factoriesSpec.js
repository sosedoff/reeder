'use strict';

var factory;

describe('reeder.feeds.factories', function() {
  beforeEach(function() {
    module('reeder.feeds.factories');
    inject(function($injector) {
      factory = $injector.get('ReederFeed');
    });
  });

  describe('ReederFeed', function() {
    it('should be defined', function() {
      expect(factory).toBeDefined();
    });
  });
});

