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

    $scope.id = $stateParams.eventId;
    $scope.number = $stateParams.questionNumber;
    $scope.name = $cookieStore.get('anwerer');
    
    questions.answerersQuestions().then(function(data){
      $scope.question = data;
      console.log(data);
    },function(error){
      console.log(error);
      $scope.message = error.data.info
    });

    $scope.postAnswer = function(answer, id, number, index){
        $location.path('/#/user/answer/'+id+'/'+number+'/'+index, {'value':answer});
    };
});


