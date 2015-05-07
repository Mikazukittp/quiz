'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserResultCtrl', function ($rootScope, $scope, $stateParams, answerers, $location,$cookieStore,answer) {

    $rootScope.noHeader = true;
    $scope.name = $cookieStore.get('anwerer');
    $scope.result = true;

    $scope.result = function(){
      answerers.answerersResult({},function(data){
      console.log(data);
      $scope.result = false;
      $scope.data = data;
    },function(error){
      console.log(error);
    });
    
    }
});


