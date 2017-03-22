'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminQuestionCtrl
 * @description
 * # AdminQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminQuestionCtrl', function ($scope, $stateParams, events, choices) {

    $scope.id = $stateParams.eventId;

    events.start({id: $scope.id}, function(data){
      console.log(data);
      $scope.question = data.question
      $scope.choices = data.choices
    },function(e){
      console.log(e);
    });

    $scope.next = function() {
      $scope.showAnswer = false;
      events.next({id: $scope.id}, function(data){
        $scope.question = data.question
        $scope.choices = data.choices
        
        if (data.is_last == true) {
          $scope.finish = true;
          events.close({id: $scope.id}, function(data){
            $scope.result = data.map(
            function(e){
              return{number:e[0], name:e[1]}
            });
          });
        };
     });
    };

    $scope.answer = function() {
      $scope.showAnswer = true;
    };

    $scope.countDown = function() {
      jQuery(function($){
        var i = 10;
        $('#countDownBox').flipcountdown({
          tick:function(){
            $('#countDownBox').show();
            if (i == -1) {
              $('#countDownBox').hide();
              return;
            };  
            return i--;
          }
        });
      })
    };

  });
