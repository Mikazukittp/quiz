'use strict';

angular.module('clientApp')
.controller('LoginCtrl', function ($scope, Auth, $location) {
  $scope.user = {};
  $scope.errors = {};

  $scope.login = function(form) {
    $scope.submitted = true;

    if(form.$valid) {
      Auth.login({
        email: $scope.user.email,
        password: $scope.user.password
      })
      .then( function() {
          console.log('login success');
          // Logged in, redirect to home
          $location.path('/admin/user');
        })
      .catch( function(err) {
          console.log('login failed');
        $scope.errors.other = err.message;
      });
    }
  };

});
