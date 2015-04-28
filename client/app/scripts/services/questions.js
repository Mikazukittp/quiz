'use strict';

/**
 * @ngdoc service
 * @name clientApp.questions
 * @description
 * # questions
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('questions', function ($resource, API_DOMAIN) {

   return $resource(API_DOMAIN + 'questions/:id/:controller',
   {
     controller:'',
     id: ''
   },
   {
     findByEventId: {
       method: 'GET',
       isArray: true,
       params: {
         event_id: 0
       }
     },
     update: {
       method: 'PATCH'
     }
   });
});
