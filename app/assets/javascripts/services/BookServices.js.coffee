
angular.module('web_book').factory 'BookList', ($resource, $http) ->

  class BookList
    constructor: (errorHandler) ->
      @service = $resource('/book/all.json')
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((->null), @errorHandler)