'use strict';

/**
 * @ngdoc service
 * @name clientApp.answer
 * @description
 * # answer
 * Service in the clientApp.
 */
angular.module('clientApp')
 .service('answer', function ($resource, API_DOMAIN) {

   return $resource(API_DOMAIN + 'answers/:controller/:id',
   {
     controller:'',
     id: ''
   },
   {
     choice: {
       method: 'POST'
    }
   });
});


