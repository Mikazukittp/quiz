'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserQuestionCtrl', function ($scope, $stateParams, questions, $location,$cookieStore) {

    $scope.number = $stateParams.questionNumber;
    $scope.name = $cookieStore.get('anwerer');
    
    questions.answerersQuestions().then(function(data){
      $scope.data = data;
      $scope.myValue = true;

      console.log(data);
  
      //主催者が開始を指定していない時の挙動
      if ($scope.number == data.question.question_number) {
        $scope.myValue = false;
        $scope.message = "クイズが開始されていません。司会者の誘導に従ってください";
      };

    },function(error){
      console.log(error);
      $scope.myValue = false;
      $scope.message = error.data.info
    });

    $scope.postAnswer = function(answer, id, number, index){
        $location.path('/#/user/answer/'+id+'/'+number+'/'+index, {'value':answer});
    };
});


