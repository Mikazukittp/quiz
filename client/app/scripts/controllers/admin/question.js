'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminQuestionCtrl
 * @description
 * # AdminQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminQuestionCtrl', function ($scope, $stateParams, questions, choices) {

    $scope.id = $stateParams.id;
    questions.get({id: $scope.id}, function(data){
      console.log(data);
      $scope.question = data;
    });
    choices.findByQuestionId({question_id: $scope.id}, function(data){
      console.log(data);
      $scope.choices = data;
    });

  });
