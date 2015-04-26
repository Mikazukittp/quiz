'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserAnswerCtrl
 * @description
 * # UserAnswerCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserAnswerCtrl', function ($scope, $stateParams,questions,$cookieStore, $location,answerers) {

  	$scope.name = $cookieStore.get('anwerer');
  	$scope.answer = $stateParams.answerNumber;
   
    answerers.choice({choice_question_number:$scope.answer},function(data){
    	console.log(data);
    })
  });
