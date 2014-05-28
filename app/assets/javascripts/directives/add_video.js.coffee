angular.module('web_book').directive 'addVideo', ($sce) ->
  restrict: 'EA'
  scope:
    code: '='
  replace: true
  template: '<div style="height:400px;"><iframe style="overflow:hidden;height:100%;width:100%" width="100%" height="100%" src="{{url}}" frameborder="0" allowfullscreen></iframe></div>'
  link: (scope) ->
    console.log 'here'
    scope.$watch('code', (newVal) ->
      if newVal
        scope.url = $sce.trustAsResourceUrl("http://v.youku.com/v_show/id_XNzA2MTM3MzQ4.html?f=22259673")
    )

