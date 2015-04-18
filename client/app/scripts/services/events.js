'use strict';

/**
 * @ngdoc service
 * @name clientApp.events
 * @description
 * # events
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('events', function ($resource, API_DOMAIN) {

    return $resource(API_DOMAIN + 'events/:controller/:id',
    {
      controller:'',
      id: ''
    },
    {
      findByUserId: {
        method: 'GET',
        isArray: true,
        params: {
          user_id: 0
        }
      },
      update: {
        method: 'PATCH'
      }
    });

});
