'use strict';

/**
 * @ngdoc service
 * @name clientApp.questions
 * @description
 * # questions
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('choices', function ($resource, API_DOMAIN) {

    return $resource(API_DOMAIN + 'choices/:controller/:id',
    {
      controller:'',
      id: ''
    },
    {
      findByQuestionId: {
        method: 'GET',
        isArray: true,
        params: {
          question_id: 0
        }
      },
      update: {
        method: 'PATCH'
      }
    });

});
