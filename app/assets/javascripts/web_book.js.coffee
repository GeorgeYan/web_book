web_book = angular.module('web_book', ['ngResource', 'ngRoute', 'ui.bootstrap'])

web_book.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").authToken
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

web_book.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', redirectTo: '/books'
  $routeProvider.when '/dashboard', redirectTo: templateUrl: '/templates/dashboard.html', controller: 'DashboardController'
  $routeProvider.when '/books', templateUrl: '/templates/book.html', controller: 'BookController'
  $routeProvider.when '/chapter_show/:chapter_id', templateUrl: '/templates/paragraph.html', controller: 'ParagraphController'

$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
