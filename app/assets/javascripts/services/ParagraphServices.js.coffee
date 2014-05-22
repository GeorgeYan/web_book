
angular.module('web_book').factory 'Paragraphs', ($resource, $http) ->

  class Paragraphs
    constructor: (errorHandle, chapter_id) ->
      console.log(chapter_id)
      @service = $resource("/chapter/#{chapter_id}.json")
      @serviceParents = $resource("/chapter_parent/#{chapter_id}.json")
      @errorHandle = errorHandle

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @service.query((->null), @errorHandle)

    parents: ->
      @serviceParents.query((->null), @errorHandle)
