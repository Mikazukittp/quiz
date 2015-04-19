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
    events.get({id: $scope.id}, function(data){
      console.log(data);
      $scope.event = data;
    });
    questions.findByEventId({event_id: $scope.id}, function(data){
      $scope.questions = data;
    });

    $scope.deleteQuestion = function(id) {
      questions.delete(id);
    }
  });
