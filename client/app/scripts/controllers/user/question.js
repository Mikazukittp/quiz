'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserQuestionCtrl', function ($scope, $routeParams, questions, $location) {

    $scope.id = $routeParams.eventId;
    $scope.number = $routeParams.questionNumber;
    
    questions.get($scope.number).then(function(data){
        $scope.question = data;
        if (!data){
          $scope.myValue = false;
        }else{
          $scope.myValue = true;
        }
    });

    $scope.postAnswer = function(answer, id, number, index){
        $location.path('/#/user/answer/'+id+'/'+number+'/'+index, {'value':answer});
    };


  });


