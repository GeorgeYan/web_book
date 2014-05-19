web_book = angular.module('web_book', ['ngResource', 'ngRoute', 'ui.bootstrap'])

web_book.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").authToken
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

web_book.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', redirectTo: '/dashboard'
  $routeProvider.when '/dashboard', templateUrl: '/templates/dashboard.html', controller: 'DashboardController'
  $routeProvider.when '/test', templateUrl: '/templates/test.html', controller: 'TestController'


$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
