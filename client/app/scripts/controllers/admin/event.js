'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:EventCtrl
 * @description
 * # EventCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminEventCtrl', function ($scope, $stateParams, $modal, events, questions, choices) {

    $scope.id = $stateParams.id;
    events.get({id: $scope.id}, function(data){
      $scope.event = data;
    });
    questions.findByEventId({event_id: $scope.id}, function(data){
      $scope.questions = data;
    });

    $scope.upsertQuestion = function(questionIndex) {
    var modalInstance;

      // 引数でidが渡されていれば既存の問題の修正
      if(questionIndex >= 0) {
        var targetQuestion = $scope.questions[questionIndex];
        choices.findByQuestionId({question_id: targetQuestion.id}, function(data){
          // modalを開く
          modalInstance = $modal.open({
            templateUrl: 'upsertQuestion.html',
            controller: 'UpsertQuestionModalCtrl',
            resolve: {
              target: function() { return {question:targetQuestion, choices:data}; }
            }
          });

          // モーダルを閉じた時のcallback関数
          modalInstance.result.then(function (result) {
            var _question = {
              event_id: $scope.id,
              sentence: result.sentence,
              points: 50,
              type_id: 1
            };
            var _choices = {
              choice1: {
                id: data[0].id,
                sentence: result.choices[0],
                choice_number: 1,
                correct_flag: result.answer==1,
                answered_times: 0
              },
              choice2: {
                id: data[1].id,
                sentence: result.choices[1],
                choice_number: 2,
                correct_flag: result.answer==2,
                answered_times: 0
              },
              choice3: {
                id: data[2].id,
                sentence: result.choices[2],
                choice_number: 3,
                correct_flag: result.answer==3,
                answered_times: 0
              },
              choice4: {
                id: data[3].id,
                sentence: result.choices[3],
                choice_number: 4,
                correct_flag: result.answer==4,
                answered_times: 0
              }
            };

            questions.update({
              id: targetQuestion.id
            }, {
              question: _question,
              choices: _choices
            }, function(data){
              console.log(data);
              $scope.questions.splice(questionIndex, 1, data.question);
            });
          });
        });
      }else{
        // modalを開く
        modalInstance = $modal.open({
          templateUrl: 'upsertQuestion.html',
          controller: 'UpsertQuestionModalCtrl',
          resolve: {
            target: function() { return undefined; }
          }
        });
        // モーダルを閉じた時のcallback関数
        modalInstance.result.then(function (result) {
          var _question = {
            event_id: $scope.id,
            sentence: result.sentence,
            points: 50,
            type_id: 1
          };
          var _choices = {
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
          };

          questions.save({
            question: _question,
            choices: _choices
          }, function(data){
            $scope.questions.push(data.question);
          });
        });
      }

    };

    $scope.deleteQuestion = function(questionIndex) {
      var modalInstance = $modal.open({
        templateUrl: 'deleteQuestion.html',
        controller: 'DeleteModalCtrl'
      });
      modalInstance.result.then(function () {
        questions.delete({id:$scope.questions[questionIndex].id}, function(){
          $scope.questions.splice(questionIndex, 1);
        });
      });
    };

  })
  .controller('UpsertQuestionModalCtrl', function ($scope, $modalInstance, target) {

    $scope.title = '問題を追加';
    $scope.answer = 1;

    // 編集の場合は要素を事前に格納する
    if(target){
      $scope.title = '問題を修正';
      $scope.sentence = target.question.sentence;
      $scope.c1 = target.choices[0].sentence;
      $scope.c2 = target.choices[1].sentence;
      $scope.c3 = target.choices[2].sentence;
      $scope.c4 = target.choices[3].sentence;
      $scope.answer = target.choices.filter(function(c){return c.correct_flag})[0].choice_number;
    }

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
