'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserAnswerCtrl
 * @description
 * # UserAnswerCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserAnswerCtrl', function ($scope, $routeParams,questions) {

    $scope.id     = $routeParams.eventId;
    $scope.answer = $routeParams.answerNumber;
    var questionNumber = Number($routeParams.questionNumber);
   
    questions.get(questionNumber).then(function(data){
        $scope.question = data;
    });
    $scope.number = questionNumber + 1;

  });
