angular.module('web_book').directive 'destroyElement', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    console.log 123
    element.bind('click', ->
      console.log 456
    )
    scope.$on('$destroy', ->)
