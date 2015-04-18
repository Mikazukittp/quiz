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


    var allQuestions = [];
    var DOMAIN = 'http://ec2-54-64-240-244.ap-northeast-1.compute.amazonaws.com/api';
    var LIST_URL = DOMAIN + '/questions/list/';
    var SHOW_URL = DOMAIN + '/questions/show/';
    var DELETE_URL = DOMAIN + '/questions/:id/delete/';
    var ANSWERERS_QUESTION_URL = DOMAIN + '/answerers/get_question';

    var questions = {};

    questions.get = function(id){
        // return allQuestions.then(function(data){
        //     return data.filter(function(question){
        //         return question.id === Number(id);
        //     })[0];
        // });
        return $resource(SHOW_URL+id).get().$promise;
    };

    questions.findByEventId = function(eventId){
        // return allQuestions.then(function(data){
        //     return data.filter(function(question){
        //         return question.eventId === Number(eventId);
        //     });
        // });
        return $resource(LIST_URL+eventId).query().$promise;
    };

    questions.delete = function(id){
      console.log('delete: '+id);
      return $resource(DELETE_URL,{id:id}).delete().$promise;
    };

    questions.winnerList = function(eventId){
         return winners.then(function(data){
            return data.filter(function(win){
                return win.eventId === Number(eventId);
            });
        });
    };

    questions.answerersQuestions = function(){
        return $resource(ANSWERERS_QUESTION_URL).get().$promise;
    }

    return questions;
});
