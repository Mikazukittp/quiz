'use strict';

/**
 * @ngdoc service
 * @name clientApp.answerers
 * @description
 * # answerers
 * Service in the clientApp.
 */
angular.module('clientApp')
 .service('answer', function ($resource, API_DOMAIN) {

   return $resource(API_DOMAIN + 'answer/:controller/:id',
   {
     controller:'',
     id: ''
   },
    choice: {
       method: 'GET',
       params: {
        id:'question_id',
        id:'choice_question_number'
       }
    },
   });
});


