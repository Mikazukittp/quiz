'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminUserCtrl', function ($scope, events) {
    var loginId = 1;
    events.findByUserId(loginId).then(function(data){
        $scope.events = data;
    });
  });
