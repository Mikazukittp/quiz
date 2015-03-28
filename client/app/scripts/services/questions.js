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
    var DOMAIN = 'http://ec2-54-64-240-244.ap-northeast-1.compute.amazonaws.com';
    var LIST_URL = DOMAIN + '/questions/list/';
    var SHOW_URL = DOMAIN + '/questions/show/';

    var questions = {};

    var allQuestions = $resource('./dummy/dummyQuestions.json').query().$promise;

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

    return questions;
});
