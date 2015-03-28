'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:EventCtrl
 * @description
 * # EventCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminEventCtrl', function ($scope, $stateParams, events, questions) {

    $scope.id = $stateParams.id;
    events.get($scope.id).then(function(data){
        $scope.event = data;
    });
    questions.findByEventId($scope.id).then(function(data){
        $scope.questions = data;
    });
  });
