'use strict';

angular.module('reeder.signin.controllers', []).
  controller('ReederSigninController', [
    '$scope', '$cookies', '$http',
    function SigninController($scope, $cookies, $http) {
      $scope.authenticate = function() {
        var form = {
          email: $scope.email,
          password: $scope.password
        };

        $http.post('/api/authenticate', form).
          success(function(data, status) {
            console.log(data);
            $cookies.api_token = data.api_token;
          }).
          error(function(data, status) {
            alert('Invalid email or password');
          });
      }
    }
  ]);

