'use strict';

/**
 * @ngdoc overview
 * @name clientApp
 * @description
 * # clientApp
 *
 * Main module of the application.
 */
angular
  .module('clientApp', [
    'ngAnimate',
    'ngCookies',
    'ngMessages',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl'
      })
     .when('/admin/question/:id', {
        templateUrl: 'views/admin.question.html',
        controller: 'AdminQuestionCtrl'
      })
     .when('/admin/user/', {
        templateUrl: 'views/admin.user.html',
        controller: 'AdminUserCtrl'
      })
     .when('/admin/event/:id', {
        templateUrl: 'views/admin.event.html',
        controller: 'AdminEventCtrl'
      })
     .when('/admin/screen/:id', {
        templateUrl: 'views/admin.screen.html',
        controller: 'AdminScreenCtrl'
      })
     .when('/user/question/:id', {
        templateUrl: 'views/user.question.html',
        controller: 'userQuestionCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
