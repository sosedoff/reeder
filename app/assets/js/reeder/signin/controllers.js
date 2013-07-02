'use strict';

angular.module('reeder.signin.controllers', []).
  controller('ReederSigninController', [
    '$scope', '$cookies', '$http', 'authService',
    function SigninController($scope, $cookies, $http, authService) {
      $scope.authenticate = function() {
        var form = {
          email: $scope.email,
          password: $scope.password
        };

        $http.post('/api/authenticate', form).
          success(function(data, status) {
            $cookies.api_token = data.api_token;
            authService.loginConfirmed();
          }).
          error(function(data, status) {
            alert('Invalid email or password');
          });
      }
    }
  ]);

