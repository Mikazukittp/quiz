'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserQuestionCtrl', function ($rootScope, $scope, $stateParams, answerers, $location,$cookieStore,answer) {

    $rootScope.noHeader = true;
    $scope.name = $cookieStore.get('anwerer');
    var questionNumber = $stateParams.questionNumber

    answerers.answerersQuestions({},function(data){
      $scope.question = data.question
      $scope.choices = data.choices
 
      $scope.errorFlag = true;
      console.log(data);
      
      if (data.is_last) {
        $scope.result = false;
      }else if(questionNumber >= data.question.question_number) {
        $scope.errorFlag = false;
        $scope.message = "司会者の指示に従い再読み込みしてください。";
      }
    },function(error){
      console.log(error);
      $scope.errorFlag = false;
      $scope.message = error.data.info
    });

    $scope.choice = function(choice){
      console.log(choice);
      var question_id = $scope.question.id;
      answer.choice({},{'question_id': question_id,'choice_question_number': choice},function(data){
      if ($scope.result == false) {
        $location.path('/user/result');
      } else {
        $location.path('/user/answer/'+ $scope.question.question_number);
      }
    },function(error){
      console.log(error);
      $scope.errorFlag = false;
      $scope.message = error.data.info
    });
    
    }
});


