@ModalInstanceCtrl = ($scope,$location, $modalInstance, items, Modify) ->
  $scope.formData =
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
