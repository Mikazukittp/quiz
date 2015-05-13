'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:QuestionCtrl
 * @description
 * # userQuestionCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('UserResultCtrl', function ($rootScope, $scope, $stateParams, answerers, $location,$cookieStore,answer) {

    $rootScope.noHeader = true;
    $scope.name = $cookieStore.get('answerer');
    $scope.result = true;

    $scope.result = function(){
      answerers.answerersResult({},function(data){
      console.log(data);
      if (data.rank == undefined) {
        $rootScope.$broadcast('show-message', {message: '司会者の指示をお待ちください。',type: 'danger'});
      } else {
        $rootScope.$broadcast('hide-message');
        $scope.result = false;
        $scope.rank = data.rank!=-1? data.rank+'位': '-';
      }
    },function(error){
      console.log(error);
    });
    
    }
});


