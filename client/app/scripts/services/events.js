'use strict';

/**
 * @ngdoc service
 * @name clientApp.events
 * @description
 * # events
 * Service in the clientApp.
 */
 angular.module('clientApp')
 .service('events', function ($resource) {

    // var API_URL = './dummy/dummyEvents.json';
    // var allEvents = $resource(API_URL).query().$promise;
    var allEvents = [];
    var DOMAIN = 'http://ec2-54-64-240-244.ap-northeast-1.compute.amazonaws.com';
    var SHOW_URL = DOMAIN + '/events/show/';
    var INDEX_URL = DOMAIN + '/events/index/';

    var events = {};

    events.getAllEvents = function(){
        return allEvents;
    };

    events.get = function(id){
        // return allEvents.then(function(data){
        //     return data.filter(function(e){
        //         return e.id === Number(id);
        //     })[0];
        // });
        return $resource(SHOW_URL+id).get().$promise;
        // return $http.json(SHOW_URL+id);
    };

    events.findByUserId = function(userId){
        // return allEvents.then(function(data){
        //     return data.filter(function(e){
        //         return e.owner === userId;
        //     });
        // });
        return $resource(INDEX_URL+userId).query().$promise;
    };
    return events;

});
