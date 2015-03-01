'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminQuestionCtrl
 * @description
 * # AdminQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminQuestionCtrl', function ($scope, $routeParams, questions) {

    $scope.id = $routeParams.id;
    questions.get($scope.id).then(function(data){
        $scope.question = data;
    });
  });
