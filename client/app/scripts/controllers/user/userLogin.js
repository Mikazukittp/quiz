'use strict';

angular.module('clientApp')
.controller('UserLoginCtrl', function ($scope,Auth, $location,$stateParams) {
  $scope.user = {};
  $scope.errors = {};
  $scope.id = $stateParams.eventId; 

  $scope.login = function(form) {
    $scope.submitted = true;
    if(form.$valid) {
      Auth.userLogin({
        name: $scope.user.name,
        id:$scope.user.id,
      })
      .then( function() {
          console.log('login success');
          // Logged in, redirect to home
          $location.path('/user/question/0');
        })
      .catch( function(err) {
          console.log(err);
          $scope.errors.other = err;
      });
    }
  };

});
