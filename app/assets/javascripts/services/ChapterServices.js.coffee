
angular.module('web_book').factory 'Chapters', ($resource, $http) ->

  class Chapters
    constructor: (errorHandle, book_id) ->
      @service = $resource("/book/#{book_id}.json")
      @errorHandle = errorHandle

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((->null), @errorHandle)