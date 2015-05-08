'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserAnswerCtrl
 * @description
 * # UserAnswerCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserAnswerCtrl', function ($scope, $stateParams,questions,$cookieStore, $location,answer) {

  	$scope.name = $cookieStore.get('anwerer');
  	$scope.number = $stateParams.questionNumber
   });
