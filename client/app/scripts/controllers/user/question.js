'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserQuestionCtrl', function ($scope, $stateParams, answerers, $location,$cookieStore) {

    $scope.name = $cookieStore.get('anwerer');
     
    answerers.answerersQuestions({},function(data){
      $scope.data = data;
      $scope.myValue = true;
      console.log(data);

    },function(error){
      console.log(error);
      $scope.myValue = false;
      $scope.message = error.data.info
    });

});


