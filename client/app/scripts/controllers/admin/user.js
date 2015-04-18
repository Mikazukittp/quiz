'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminUserCtrl', function ($scope, events, Auth) {
    // var loginId = 1;
    var loginId = Auth.getCurrentUser().id;
    events.findByUserId(loginId).then(function(data){
        $scope.events = data;
        console.log(data);
    });
    $scope.createEvent = function() {
      events.create().then(function(data){
        console.log(data);
        $scope.$apply();
      });
    };
  });
