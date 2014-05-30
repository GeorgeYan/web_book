angular.module('web_book').factory 'Annotation', ($resource, $http) ->
  class Annotation
    constructor: (errorHandler) ->
      @service = $resource('./annotation/:id.json',
        {id: '@id'},
        {deleteAnnotation: {method: 'post',url: './annotation/paragraphId.json'}})


      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'


    create: (attrs) ->
      new @service(attrs).$save ((data) -> data ), @errorHandler

    delete: (uuid) ->
      new @service().$delete {id: uuid}, (-> null), @errorHandler
      #new @service(attrs).$delete {id: attrs.paragraphId}, (-> null), @errorHandler
