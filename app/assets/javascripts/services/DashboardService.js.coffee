angular.module('web_book').factory 'Book', ($resource, $http) ->
  class Book
    constructor: (errorHandler) ->
      @service = $resource('chapter/101.json',
        {id: '@id'},
        {update: {method: 'PATCH'}},
      )
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((-> null), @errorHandler)

