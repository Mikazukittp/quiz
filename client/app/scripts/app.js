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
    'ngTouch',
    'ui.bootstrap'
  ])
  .config(function ($routeProvider, $httpProvider) {
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
     .when('/login', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
      })
     .when('/signup', {
        templateUrl: 'views/signup.html',
        controller: 'SignupCtrl'
      })
     .when('/account/setting', {
        templateUrl: 'views/settings.html',
        controller: 'SettingCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
