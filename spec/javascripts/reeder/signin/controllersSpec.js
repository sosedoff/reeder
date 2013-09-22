'use strict';

describe('reeder.signin.controllers', function() {
  describe('ReederSigninController', function() {
    var $httpBackend, authService, cookies, ctrl, scope;

    beforeEach(module('reeder.signin.controllers'));
    beforeEach(function() {
      inject(function(_$httpBackend_, $rootScope, $controller) {
        $httpBackend = _$httpBackend_;
        authService = jasmine.createSpyObj('authService', ['loginConfirmed']);
        cookies = {};
        scope = $rootScope.$new();

        ctrl = $controller('ReederSigninController', {
          $rootScope: {}
        , $scope: scope
        , $cookies: cookies
        , authService: authService
        });
      });
    });
    afterEach(function() {
      $httpBackend.verifyNoOutstandingExpectation();
      $httpBackend.verifyNoOutstandingRequest();
    });

    describe('authenticate', function() {
      beforeEach(function() { scope.email = 'user@gmail.com'; scope.password = 'password'; });

      describe('response is success', function() {
        beforeEach(function() { $httpBackend.when('POST', '/api/authenticate').respond(200, { api_token: 'APITOKEN' }); });

        it('sets $cookies.api_token', function() {
          scope.authenticate();
          $httpBackend.flush();
          expect(cookies.api_token).toEqual('APITOKEN');
        });

        it('calls authService.loginConfirmed()', function() {
          scope.authenticate();
          $httpBackend.flush();
          expect(authService.loginConfirmed).toHaveBeenCalled();
        });
      });

      describe('response is error', function() {
        beforeEach(function() { $httpBackend.when('POST', '/api/authenticate').respond(401, ''); });

        it('alerts', function() {
          spyOn(window, 'alert');
          scope.authenticate();
          $httpBackend.flush();
          expect(window.alert).toHaveBeenCalled();
        });
      });
    });
  });
});

