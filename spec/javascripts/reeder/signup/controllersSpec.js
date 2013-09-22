'use strict';

describe('reeder.signup.controllers', function() {
  describe('ReederSignupController', function() {
    var $httpBackend, ctrl, scope;

    beforeEach(module('reeder.signup.controllers'));
    beforeEach(function() {
      inject(function(_$httpBackend_, $rootScope, $controller) {
        $httpBackend = _$httpBackend_;
        scope = $rootScope.$new();

        ctrl = $controller('ReederSignupController', {
          $rootScope: {}
        , $scope: scope
        });
      });
    });
    afterEach(function() {
      $httpBackend.verifyNoOutstandingExpectation();
      $httpBackend.verifyNoOutstandingRequest();
    });

    describe('create_account', function() {
      beforeEach(function() { spyOn(window, 'alert'); });

      it('alerts when passwords do not match', function() {
        scope.user = { password: 'foo', password_confirmation: 'bar' };
        scope.create_account();
        expect(alert).toHaveBeenCalled();
      });

      describe('response is success', function() {
        beforeEach(function() { $httpBackend.when('POST', '/api/users').respond(200, ''); });

        it('alerts with success message', function() {
          scope.user = { password: 'foobar', password_confirmation: 'foobar' };
          scope.create_account();
          $httpBackend.flush();
          expect(alert).toHaveBeenCalledWith('Account has been created!');
        });
      });

      describe('response is error', function() {
        beforeEach(function() { $httpBackend.when('POST', '/api/users').respond(500, { error: 'Error message' }); });

        it('alerts with error message', function() {
          scope.user = { password: 'foobar', password_confirmation: 'foobar' };
          scope.create_account();
          $httpBackend.flush();
          expect(alert).toHaveBeenCalledWith('Unable to create account: Error message');
        });
      });
    });
  });
});

