'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserQuestionCtrl', function ($scope, $stateParams, answerers, $location,$cookieStore,answer) {

    $scope.name = $cookieStore.get('anwerer');
     
    answerers.answerersQuestions({},function(data){
      $scope.data = data;
      $scope.myValue = true;
      console.log(data);
      if ($scope.data.is_last) {
        console.log("aa");
      }
    },function(error){
      console.log(error);
      $scope.myValue = false;
      $scope.message = error.data.info
    });

    $scope.choice = function(choice){
      console.log(choice);
      var question_id = $scope.data.question.id;

      answer.choice({},{'question_id': question_id,'choice_question_number': choice},function(data){
      console.log(data);
      $location.path('/user/answer');
    },function(error){
      console.log(error);
      $scope.myValue = false;
      $scope.message = error.data.info
    });
    
    }
});


