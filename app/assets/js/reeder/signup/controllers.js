'use strict';

angular.module('reeder.signup.controllers', []).
  controller('ReederSignupController', [
    '$scope', '$http',
    function SignupController($scope, $http) {
      $scope.create_account = function() {
        var user = $scope.user;
        var form = {user: user};

        if (user.password != user.password_confirmation) {
          alert('Passwords do not match');
          return;
        }

        $http.post('/api/users', form).
          success(function(data, status) {
            alert('Account has been created!');
          }).
          error(function(data, status) {
            alert("Unable to create account: " + data.error);
          });
      }
    }
  ]);

