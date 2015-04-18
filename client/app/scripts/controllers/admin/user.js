'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminUserCtrl', function ($scope, events, Auth, $modal) {
    // var loginId = 1;
    var loginId = Auth.getCurrentUser().id;
    events.findByUserId({user_id: loginId}, function(data){
      console.log(data);
      $scope.events = data;
    });

    $scope.createEvent = function() {
      var modalInstance = $modal.open({
        templateUrl: 'createEvent.html',
        controller: 'CreateEventModalCtrl'
      });
      modalInstance.result.then(function (result) {
        events.save({
          event: {
            name: result.name,
            description: result.description,
            event_date: '2015/5/1',
            limit_date: '2015/5/8',
            time_limit: 60,
            course_id: 1
          }
        }, function(data){
          console.log(data);
          $scope.events.push(data.event);
        });
      });
    };

    $scope.deleteEvent = function(id) {
      var modalInstance = $modal.open({
        templateUrl: 'deleteEvent.html',
        controller: 'DeleteModalCtrl'
      });
      modalInstance.result.then(function () {
        events.delete({id:id}, function(){
            $scope.events.forEach(function(e, i){
              if(e.id==id) $scope.events.splice(i,1);
            });
        });
      });
    };

  })
  .controller('CreateEventModalCtrl', function ($scope, $modalInstance) {
    $scope.ok = function () {
      var result = {
        name: $scope.name,
        description: $scope.description
      }
      $modalInstance.close(result);
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
  })
  .controller('DeletModalCtrl', function ($scope, $modalInstance) {
    $scope.ok = function () {
      $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
  });
