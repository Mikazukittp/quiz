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
    $scope.type = 'info';

    $scope.$on('show-message', function(event, data){
      $scope.message = data.message;
      $scope.type = data.type;
      $scope.isShow = true;
    });

    $scope.$on('hide-message', function(event, data){
      $scope.closeMessage();
    });

    $scope.closeMessage = function() {
      $scope.isShow = false;
    };

  });
