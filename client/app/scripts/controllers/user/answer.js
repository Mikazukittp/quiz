'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserAnswerCtrl
 * @description
 * # UserAnswerCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserAnswerCtrl', function ($scope, $stateParams,questions,$cookieStore, $location) {

  	console.log($location.search('value'));
  	$scope.questionNumber = Number($stateParams.questionNumber) + 1;
  	$scope.name = $cookieStore.get('anwerer');
  	$scope.answer = $stateParams.answerNumber;
   
  });
