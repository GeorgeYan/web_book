@BookController = ($scope,$http, $log, $modal, BookList) ->

  $scope.books_init = ->
    @bookListService = new BookList(serverErrorHandler)
    $scope.books = @bookListService.all()

  $scope.bookDetail = (book_id) ->
    alert("#{book_id}")

  $scope.bookChapter = (book_name, book_id) ->
    $modal.open({
      templateUrl: 'templates/chapter.html',
      controller: ChapterController
      resolve:
        book_id: ->
          book_id
        book_name: ->
          book_name
    })

  $scope.bookDelete = (book_name, book_id) ->
    if confirm("确定删除书籍《#{book_name}》")
      $http.delete("./book/#{book_id}.json").success( ->
        alert("删除成功！")
        $scope.books_init()
      ).error( ->
        alert("删除失败！")
        $scope.books_init()
      )


  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again")