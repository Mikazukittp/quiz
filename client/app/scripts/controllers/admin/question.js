'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminQuestionCtrl
 * @description
 * # AdminQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminQuestionCtrl', function ($scope, $routeParams, questions) {

    $scope.id = $routeParams.eventId;
    $scope.number = $routeParams.questionNumber;

    questions.get($scope.number).then(function(data){
        $scope.question = data;
        console.log(data);

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
  });
