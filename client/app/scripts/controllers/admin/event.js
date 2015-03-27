'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:EventCtrl
 * @description
 * # EventCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminEventCtrl', function ($scope, $routeParams, events, questions) {

    $scope.id = $routeParams.id;
    events.get($scope.id).then(function(data){
        $scope.event = data;
        console.log(data);
    });
    questions.findByEventId($scope.id).then(function(data){
        $scope.questions = data;
    });
  });
