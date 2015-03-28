'use strict';

angular.module('clientApp')
  .factory('User', function ($resource) {
    var API_DOMAIN = 'http://ec2-54-64-240-244.ap-northeast-1.compute.amazonaws.com/admin_users';
    return $resource(API_DOMAIN + '/:id/:controller', {
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
        }
      }
	  });
  });
