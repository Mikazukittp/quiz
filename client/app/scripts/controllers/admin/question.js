'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminQuestionCtrl
 * @description
 * # AdminQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminQuestionCtrl', function ($scope, $stateParams, questions, choices) {

    $scope.id = $routeParams.eventId;
    $scope.number = $routeParams.questionNumber;

    questions.get($scope.number).then(function(data){

        $scope.question = data;

        if (!data) {
        	$scope.finish = true;
                questions.winnerList($scope.id).then(function(win){
                $scope.winnerList = win[0];
                console.log(win);
            });
        }else {
        	$scope.finish = false;
        }
    });
    choices.findByQuestionId($scope.id).then(function(data){
        console.log(data);
        $scope.choices = data;
    });

  });
