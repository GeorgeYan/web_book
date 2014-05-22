@ChapterController = ($scope, $modalInstance, $location, $http, book_id, book_name, Chapters) ->

  $scope.book_id = book_id
  $scope.book_name = book_name
  @chaptersService = new Chapters(serverErrorHandler, book_id)
  $scope.chapters = @chaptersService.all()
  console.log($scope.chapters)

  $scope.chapters_init =->
    @chaptersService = new Chapters(serverErrorHandler, book_id)
    $scope.chapters = @chaptersService.all()


  $scope.chapter_show = (chapter_id) ->
    $modalInstance.close()
    $location.path("/chapter_show/#{chapter_id}")


  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")


