'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserAnswerCtrl
 * @description
 * # UserAnswerCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserAnswerCtrl', function ($scope, $stateParams,questions,$cookieStore) {

  	$scope.questionNumber = Number($stateParams.questionNumber) + 1;
  	$scope.name = $cookieStore.get('anwerer');

    $scope.id     = $stateParams.questionId;
    $scope.answer = $stateParams.answerNumber;
   
  });
