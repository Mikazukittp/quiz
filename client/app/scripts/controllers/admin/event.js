'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:EventCtrl
 * @description
 * # EventCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminEventCtrl', function ($scope, $stateParams, events, questions, $modal) {

    $scope.id = $stateParams.id;
    events.get({id: $scope.id}, function(data){
      console.log(data);
      $scope.event = data;
    });
    questions.findByEventId({event_id: $scope.id}, function(data){
      $scope.questions = data;
    });

    $scope.createQuestion = function() {
      var modalInstance = $modal.open({
        templateUrl: 'createQuestion.html',
        controller: 'CreateQuestionModalCtrl'
      });
      modalInstance.result.then(function (result) {
        console.log(result);
        questions.save({
          question: {
            event_id: $scope.id,
            sentence: result.sentence,
            points: 50,
            type_id: 1
          },
          choices: {
            choice1: {
              sentence: result.choices[0],
              choice_number: 1,
              correct_flag: result.answer==1,
              answered_times: 0
            },
            choice2: {
              sentence: result.choices[1],
              choice_number: 2,
              correct_flag: result.answer==2,
              answered_times: 0
            },
            choice3: {
              sentence: result.choices[2],
              choice_number: 3,
              correct_flag: result.answer==3,
              answered_times: 0
            },
            choice4: {
              sentence: result.choices[3],
              choice_number: 4,
              correct_flag: result.answer==4,
              answered_times: 0
            }
          }
        }, function(data){
          console.log(data);
          // $scope.eventsに追加
          $scope.questions.push(data.question);
        });
      });
    };

    $scope.deleteQuestion = function(id) {
      var modalInstance = $modal.open({
        templateUrl: 'deleteQuestion.html',
        controller: 'DeleteModalCtrl'
      });
      modalInstance.result.then(function () {
        questions.delete({id:id}, function(){
            $scope.questions.forEach(function(q, i){
              if(q.id==id) $scope.questions.splice(i,1);
            });
        });
      });
    };
  })
  .controller('CreateQuestionModalCtrl', function ($scope, $modalInstance) {
    $scope.answer = 1;
    $scope.ok = function () {
      var result = {
        sentence: $scope.sentence,
        choices: [$scope.c1, $scope.c2, $scope.c3, $scope.c4],
        answer: $scope.answer
      }
      $modalInstance.close(result);
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
  })
  .controller('DeleteModalCtrl', function ($scope, $modalInstance) {
    $scope.ok = function () {
      $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
  });
