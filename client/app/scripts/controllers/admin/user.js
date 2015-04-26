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
    events.findByUserId({user_id: loginId}, function(data){
      console.log(data);
      $scope.events = data;
    });
    $scope.createEvent = function() {
      events.create({}, function(data){
        console.log(data);
        $scope.$apply();
      });
    };
  });
