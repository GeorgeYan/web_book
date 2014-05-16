@ModalInstanceCtrl = ($scope, $routeParams, $location, $modalInstance, items, paragraphId,  Modify) ->
  $scope.formData =
    paragraphId : paragraphId
    content: ''
  $scope.items = items
  $scope.selected = {
    item: $scope.items[0]
  }

  $scope.ok = ->
    Modify.createContent($scope.formData)
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.update = ->
