angular.module('web_book').directive 'ngGetSelection', ($timeout)->
  text = ''
  getSelectedText = ->
    text = ''
    if window.getSelection?
      text = window.getSelection().toString()
    else if document.selection? && document.selection.type == "Text"
      text = document.selection.createRange().text
    return text

  return {
    restrict: 'A'
    scope:
      ngGetSelection: '='
    link: (scope,element) ->
      $timeout(getSelection = ->
        newText = getSelectedText()

        if text == newText
          text = newText
          console.log text
          element.val(newText)
          scope.$apply.ngGetSelection = newText
        $timeout(getSelection, 50)
      , 50)
  }
