#@DashboardController = ($scope, $routeParams, $http, $location, $modal, $log, Book, Annotation, Modify, UUID) ->

  #$scope.init = ->
    #@listsService = new Book(serverErrorHandler)
    #$scope.lists = @listsService.all()

    #drawColor()

  #$scope.items = ['item1', 'item2', 'item3']

  #$scope.code = '1234'

  #$scope.addColor = (index) ->
    #console.log $scope.lists.length
    #a = $scope.lists.indexOf(index)
    #console.log a

  #$scope.highlight = (color, paragraphId) ->
    #if window.getSelection
      #content = window.getSelection().toString()
      #try
        #if !document.execCommand("BackColor", false, color)
          ##makeEditHightlight(color)
          #sel = window.getSelection()
          #if sel.rangeCount && sel.getRangeAt
            #range = sel.getRangeAt(0)

            #node = document.getElementById('27226')

            #start = range.startOffset
            #end = range.endOffset


          #document.designMode = "on"

          #if range
            #sel.removeAllRanges()
            #sel.addRange(range)

          #if !document.execCommand("HiliteColor", false, color)
            #document.execCommand("BackColor", false, color)

          #document.designMode = "off"

          #@annotationService = new Annotation(serverErrorHandler)
          #annotation =
            #paragraphId: paragraphId
            #UUID: UUID.newuuid()
            #content: content
            #color: color
            #start: start
            #end: end
          #@annotationService.create(annotation)
          #console.log v.data
      #catch ex
        ##makeEditHightlight(color)
    #else if document.selection && document.selection.createRange
      #range = document.selection.createRange()
      #range.execCommand("BackColor", false, color)

  #$scope.removeHighlight = (color, paragraphId) ->
    #if window.getSelection
      #content = window.getSelection().toString()
      #try
        #if !document.execCommand("BackColor", false, color)
          ##makeEditHightlight(color)
          #sel = window.getSelection()
          #if sel.rangeCount && sel.getRangeAt
            #range = sel.getRangeAt(0)
            #start = range.startOffset
            #end = range.endOffset

          #document.designMode = "on"

          #if range
            #sel.removeAllRanges()
            #sel.addRange(range)

          #if !document.execCommand("HiliteColor", false, color)
            #document.execCommand("BackColor", false, color)

          #document.designMode = "off"

          #@annotationService = new Annotation(serverErrorHandler)
          #annotation =
            #start: start
            #end: end
            #paragraphId: paragraphId
          #@annotationService.delete(annotation)
      #catch ex
        ##makeEditHightlight(color)
    #else if document.selection && document.selection.createRange
      #range = document.selection.createRange()
      #range.execCommand("BackColor", false, color)

  #$scope.open = (paragraphId, size) ->
    #$scope.paragraphId = paragraphId
    #modalInstance = $modal.open({
      #templateUrl: '/templates/myModalContent.html',
      #controller: ModalInstanceCtrl,
      #size: size,
      #resolve:
        #items: ->
          #$scope.items

        #paragraphId: ->
          #$scope.paragraphId
    #})

    #modalInstance.result.then (selectedItem) ->
      #$scope.selected = selectedItem
      #->
        #$log.info('Modal dismiss at: ' + new Date())

  #$scope.edit = (modifyId, currentContent, size) ->
    #$scope.modifyId = modifyId
    #$scope.currentContent = currentContent
    #modalInstance = $modal.open({
      #templateUrl: '/templates/myModalEditContent.html',
      #controller: ModalEditCtrl,
      #size: size,
      #resolve:
        #modifyId: ->
          #$scope.modifyId

        #currentContent: ->
          #$scope.currentContent
    #})

  #$scope.delete = (modifyId) ->
    #if confirm("哥们确定要干掉？")
      #$http.delete("./midify_paragraph/#{modifyId}.json").success( ->
        #console.log("删除成功！")
      #).error( ->
        #console.error("删除失败！")
      #)
    #return true

  #serverErrorHandler = ->
    #alert("There was a server error, please reload the page and try again")

  ##makeEditHightlight = (color)->
    ##sel = window.getSelection()
    ##if sel.rangeCount && sel.getRangeAt
      ##range = sel.getRangeAt(0)

    ##document.designMode = "on"

    ##if range
      ##sel.removeAllRanges()
      ##sel.addRange(range)

    ##if !document.execCommand("HiliteColor", false, color)
      ##document.execCommand("BackColor", false, color)

    ##document.designMode = "off"

  #drawColor = ->

