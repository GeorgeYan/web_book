angular.module('web_book').controller "DashboardController", ($scope, $routeParams, $location) ->
  $scope.init = ->
    @listsService = new Book(serverErrorHander)
    $scope.lists = @listsService.all()
  $scope.addItem = ->
    alert 1
