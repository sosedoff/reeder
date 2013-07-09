'use strict';

var ctrl, scope;

describe('reeder.signup.controllers', function() {
  describe('ReederSignupController', function() {
    beforeEach(function() {
      module('reeder.signup.controllers');

      inject(function($rootScope, $controller) {
        scope = $rootScope.$new();

        ctrl = $controller('ReederSignupController', {
          $rootScope: {}
        , $scope: scope
        });
      });
    });

    describe('create_account()', function() {
      it('alerts when passwords do not match', function() {
        spyOn(window, 'alert');
        scope.user = { password: 'foo', password_confirmation: 'bar' };
        scope.create_account();
        expect(alert).toHaveBeenCalled();
      });
    });
  });
});

