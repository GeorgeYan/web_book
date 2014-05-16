@ModalEditCtrl = ($scope, $routeParams, $location, $modalInstance, modifyId, currentContent, Modify) ->
  $scope.formData =
    modifyId : modifyId
    currentContent: currentContent

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.update = ->
    Modify.updateContent($scope.formData)
    $modalInstance.close()

