@DashboardController = ($scope, $routeParams, $http, $location, $modal, $log, Book,Modify) ->

  $scope.init = ->
    @listsService = new Book(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.items = ['item1', 'item2', 'item3']

  $scope.open = (paragraphId, size) ->
    $scope.paragraphId = paragraphId
    modalInstance = $modal.open({
      templateUrl: '/templates/myModalContent.html',
      controller: ModalInstanceCtrl,
      size: size,
      resolve:
        items: ->
          $scope.items

        paragraphId: ->
          $scope.paragraphId
    })

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
      ->
        $log.info('Modal dismiss at: ' + new Date())

  $scope.edit = (modifyId, currentContent, size) ->
    $scope.modifyId = modifyId
    $scope.currentContent = currentContent
    modalInstance = $modal.open({
      templateUrl: '/templates/myModalEditContent.html',
      controller: ModalEditCtrl,
      size: size,
      resolve:
        modifyId: ->
          $scope.modifyId

        currentContent: ->
          $scope.currentContent
    })

  $scope.delete = (modifyId) ->
    if confirm("哥们确定要干掉？")
      $http.delete("./midify_paragraph/#{modifyId}.json").success( ->
        console.log("删除成功！")
      ).error( ->
        console.error("删除失败！")
      )
    return true





  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")
