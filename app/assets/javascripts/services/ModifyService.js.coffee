angular.module('web_book').factory 'Modify', ['$http', ($http) ->
  Modify =
    content: ''

  Modify.createContent = (formData) ->
    if formData.id == '' or formData.content == ''
      alert('Neither the id nor the content are allowed to be blank')
      return false

    data =
      paragraphId: formData.paragraphId
      content: formData.content

    console.log(data)

    $http.post('./midify_paragraph.json', data).success((data)->
      console.log('Add successfully')
    ).error( ->
      console.error('Add failed')
    )

    return true

  Modify.updateContent = (formData) ->
    if formData.id = '' or formData.currentContent == ''
      alert('Neither the id nor the currentContent are allowed to be blank')
      return false

    modifyId =  formData.modifyId
    console.log(modifyId)
    data =
      content: formData.currentContent

    console.log(data)

    $http.put("./midify_paragraph/#{modifyId}.json", data).success((data)->
      console.log('Add successfully')
    ).error( ->
      console.error('Add failed')
    )


  return Modify
]
