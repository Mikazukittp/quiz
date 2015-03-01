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

    var API_URL = './dummy/dummyEvents.json';
    var allEvents = $resource(API_URL).query().$promise;
    var events = {};

    events.getAllEvents = function(){
        return allEvents;
    };

    events.get = function(id){
        return allEvents.then(function(data){
            return data.filter(function(e){
                return e.id === Number(id);
            })[0];
        });
    };

    events.findByUserId = function(userId){
        return allEvents.then(function(data){
            return data.filter(function(e){
                return e.owner === userId;
            });
        });
    };
    return events;

});
