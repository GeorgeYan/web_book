@ParagraphController = ($scope, $routeParams, $sce, $http, Paragraphs) ->


  $scope.modifyurl = false
  $scope.modifyimg = false
  $scope.modifyvideo = false
  $scope.highlightText = "a"

  $scope.paragraphs_init = ->
    @paragraphsService = new Paragraphs(serverErrorHandler, $routeParams.chapter_id)
    $scope.paragraphs = @paragraphsService.all()
    $scope.paragraphParents = @paragraphsService.parents()

  $scope.trustSrc = (url) ->
    $sce.trustAsResourceUrl("http://" + url) if url

  $scope.addModify = (paragraph) ->
    paragraph.show = !paragraph.show

  $scope.addModifyURL = () ->
    $scope.modifyurl = !$scope.modifyurl
    $scope.modifyimg = false
    $scope.modifyvideo = false

  $scope.addModifyIMG = () ->
    $scope.modifyurl = false
    $scope.modifyimg = !$scope.modifyimg
    $scope.modifyvideo = false

  $scope.addModifyVideo = ()->
    $scope.modifyurl = false
    $scope.modifyimg = false
    $scope.modifyvideo = !$scope.modifyvideo

  $scope.mouseDown = (evt) ->
    alert("The values is bb")

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")

