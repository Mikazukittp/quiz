'use strict';

/**
 * @ngdoc function
 * @name clientApp.controller:AdminPaymentCtrl
 * @description
 * # AdminPaymentCtrl
 * Controller of the clientApp
 */
angular.module('clientApp')
  .controller('AdminPaymentCtrl', function ($scope, $http) {

    var API_URL = 'http://sample_api.com'

    $scope.num = 12345;
    $scope.str = 'hoge'

    $scope.postCardInfo = function(){
        console.log('post info!');
        $http.post(URL, {'card_num': $scope.num, 'user_name': $scope.str});
    }

  });
