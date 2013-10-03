'use strict';

describe('reeder.sidebar.directives', function() {
  describe('reederSidebar', function() {
    var element, scope;

    beforeEach(module('reeder.sidebar'));
    beforeEach(module('/views/sidebar.html'));
    beforeEach(function() {
      inject(function($rootScope, $compile) {
        element = angular.element('<div><reeder-sidebar></reeder-sidebar></div>');
        scope = $rootScope;
        $compile(element)(scope);
        scope.$digest();
      });
    });

    it('renders uls', function() {
      expect(element.find('ul').length).toBeGreaterThan(0);
    });
  });
});

