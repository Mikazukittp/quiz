'use strict';

/**
 * @ngdoc service
 * @name clientApp.questions
 * @description
 * # questions
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('questions', function ($resource) {

    var allQuestions = $resource('./dummy/dummyQuestions.json').query().$promise;
    var winners = $resource('./dummy/dummyWinnerList.json').query().$promise;
    var questions={};

    questions.get = function(id){
        return allQuestions.then(function(data){
            return data.filter(function(question){
                return question.id === Number(id);
            })[0];
        });
    };

    questions.findByEventId = function(eventId){
        return allQuestions.then(function(data){
            return data.filter(function(question){
                return question.eventId === Number(eventId);
            });
        });
    };

    questions.winnerList = function(eventId){
         return winners.then(function(data){
            return data.filter(function(win){
                return win.eventId === Number(eventId);
            });
        });
    };

    return questions;
});
