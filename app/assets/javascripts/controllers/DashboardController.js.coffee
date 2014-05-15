@DashboardController = ($scope, $routeParams, $location, $modal, $log, Book) ->

  $scope.init = ->
    @listsService = new Book(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.items = ['item1', 'item2', 'item3']

  $scope.open = (size)->
    modalInstance = $modal.open({
      templateUrl: '/templates/myModalContent.html',
      controller: ModalInstanceCtrl,
      size: size,
      resolve:
        items: ->
          $scope.items
    })

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
      ->
        $log.info('Modal dismiss at: ' + new Date())

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")

