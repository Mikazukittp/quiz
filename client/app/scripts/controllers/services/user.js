'use strict';

angular.module('clientApp')
  .factory('User', function ($resource, API_DOMAIN) {
    return $resource(API_DOMAIN + 'admin_users/:id/:controller', {
      id: '@_id'
    },
    {
      signup: {
        method: 'POST',
        params: {
          controller:''
        }
      },
      changePassword: {
        method: 'PUT',
        params: {
          controller:'password'
        }
      },
      get: {
        method: 'GET',
        params: {
          controller:'me'
        }
      }
	  });
  });
