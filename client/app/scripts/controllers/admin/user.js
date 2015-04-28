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

    $scope.upsertEvent = function(eventIndex) {
      // 引数でidが渡されていれば既存イベントの修正
      var targetEvent = eventIndex >= 0? $scope.events[eventIndex]: undefined;

      // modalを開く
      var modalInstance = $modal.open({
        templateUrl: 'upsertEvent.html',
        controller: 'UpsertEventModalCtrl',
        resolve: {
          target: function() { return targetEvent; }
        }
      });

      // モーダルを閉じた時のcallback関数
      modalInstance.result.then(function (result) {
        var event = {
          name: result.name,
          description: result.description,
          event_date: result.selectedDate,
          limit_date: shiftDate(result.selectedDate, 7),
          time_limit: 60,
          course_id: 1
        };

        if(eventIndex >= 0) {
          events.update({
            id: targetEvent.id
          }, {
            event: event
          }, function(data){
            console.log(data);
            $scope.events.splice(eventIndex, 1, data.event);
            console.log($scope.events);
          });
        }else{
          events.save({
            event: event
          }, function(data){
            $scope.events.push(data.event);
          });
        }
      });

    };

    $scope.deleteEvent = function(eventIndex) {
      var modalInstance = $modal.open({
        templateUrl: 'deleteEvent.html',
        controller: 'DeleteModalCtrl'
      });
      modalInstance.result.then(function () {
        events.delete({id:$scope.events[eventIndex].id}, function(){
          $scope.events.splice(eventIndex, 1);
        });
      });
    };

    // 日付をずらす処理
    function shiftDate(dateStr, shiftValue) {
      var limit = new Date(dateStr);
      limit.setDate(limit.getDate() + shiftValue);
      var limitStr = limit.getFullYear()  + "/" + (limit.getMonth() + 1) + "/" + limit.getDate();
      return limitStr;
    }

  })
  .controller('UpsertEventModalCtrl', function ($scope, $modalInstance, target) {
    $scope.title = '新規イベントを作成';

    // 編集の場合は要素を事前に格納する
    if(target){
      $scope.title = 'イベントの情報を修正';
      $scope.name = target.name;
      $scope.selectedDate = target.event_date;
      $scope.description = target.description;
    }

    $scope.ok = function () {
      var result = {
        name: $scope.name,
        selectedDate: $scope.selectedDate,
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
