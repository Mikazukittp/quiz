'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:MessageCtrl
 * @description
 * # MessageCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('MessageCtrl', function ($scope) {
    $scope.message = '';
    $scope.isShow = false;

    $scope.$on('error-message', function(event, data){
      $scope.message = data.message;
      $scope.isShow = true;
    });

    $scope.closeMessage = function() {
      $scope.isShow = false;
    };

  });
