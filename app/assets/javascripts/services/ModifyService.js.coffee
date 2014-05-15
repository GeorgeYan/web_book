angular.module('web_app').factory 'Modify', ['$http', ($http) ->
  Modify.createContent = (addContent) ->
    if addContent.content = ''
      alert('The content is not allowed to be blank')
      return false

    data =
      content: addContent.content

    $http.post('./posts.json', data).success((data)->
      console.log('Add successfully')
    ).error( ->
      console.error('Add failed')
    )

    return true

]
