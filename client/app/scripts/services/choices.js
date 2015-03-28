'use strict';

/**
 * @ngdoc service
 * @name clientApp.questions
 * @description
 * # questions
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('choices', function ($resource) {

    // var allChoices = [];
    var DOMAIN = 'http://ec2-54-64-240-244.ap-northeast-1.compute.amazonaws.com';
    var LIST_URL = DOMAIN + '/choices/list/';
    var SHOW_URL = DOMAIN + '/choices/show/';

    var choices = {};

    // var allQuestions = $resource('./dummy/dummyQuestions.json').query().$promise;

    choices.get = function(id){
        // return allQuestions.then(function(data){
        //     return data.filter(function(question){
        //         return question.id === Number(id);
        //     })[0];
        // });
        return $resource(SHOW_URL+id).get().$promise;
    };

    choices.findByQuestionId = function(questionId){
        // return allQuestions.then(function(data){
        //     return data.filter(function(question){
        //         return question.questionId === Number(questionId);
        //     });
        // });
        return $resource(LIST_URL+questionId).query().$promise;
    };

    return choices;
});
