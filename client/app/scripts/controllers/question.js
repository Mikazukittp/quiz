'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # QuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('QuestionCtrl', function ($scope,$http) {
 
    //TODO parseのテストデータを取得 本来を独自APIを取得する
    Parse.initialize("UJbVFp808zweMERrwv5CsVIHNvzfoa5QOegdVdlc", "nQ47bfljzSbtk7lvk6YfPOBasiahjTS7ORK2sLp4");
    var QuestionClass = Parse.Object.extend("Question");
    var query = new Parse.Query(QuestionClass);
    query.equalTo('question_number', 1)
    query.find({
        success: function(results) {
            console.dir(results);
            $scope.question = {
                                "number":results[0].get('question_number'),
                                "text":results[0].get('question_text'),
                                "imageUrl":results[0].get('question_image'),
                                "question1":results[0].get('question1'),
                                "question2":results[0].get('question2'),
                                "question3":results[0].get('question3'),
                                "question4":results[0].get('question4')
                                };
            $scope.$apply();
        },
        error: function(error) {
        }
    });

});