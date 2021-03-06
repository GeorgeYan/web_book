@DashboardController = ($scope, $routeParams, $http, $location, $modal, $log, Book, Annotation, Modify, UUID) ->

  $scope.init = ->
    @listsService = new Book(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.items = ['item1', 'item2', 'item3']

  $scope.code = '1234'

  $scope.draw = ->
    for list in $scope.lists
      if list.annotation.length > 1
        for annotation in list.annotation
          drawColor(annotation)

  $scope.highlight = (color, paragraphId) ->
    sel = window.getSelection()
    range = sel.getRangeAt(0)

    start = range.startOffset
    end = range.endOffset
    content = range.toString()

    uuid = UUID.newuuid()

    nNd = document.createElement("span")
    nNd.setAttribute("id", uuid)
    nNd.style.color = color

    range.surroundContents(nNd)

    @annotationService = new Annotation(serverErrorHandler)
    annotation =
      paragraphId: paragraphId
      uuid: uuid
      content: content
      color: color
      start: start
      end: end
    @annotationService.create(annotation)

  $scope.removeHighlight = ->
    sel = window.getSelection()
    nNd = sel.anchorNode
    node = nNd.parentElement

    uuid = node.id

    if uuid? && uuid.length == 32
      if !node.parentElement
        return
      while node.firstChild
        node.parentElement.insertBefore(node.firstChild, node)
        node.parentElement.removeChild(node)

      @annotationService = new Annotation(serverErrorHandler)
      @annotationService.delete(uuid)
    else
      selectErrorHandler()

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

  selectErrorHandler = ->
    alert("操作失败")

  drawColor = (annotation) ->
    el = document.getElementById(annotation.paragraph_id)
    start = annotation.start
    end = annotation.end

    if document.createRange && window.getSelection
      range = document.createRange()
      range.selectNodeContents(el)

      textNodes = getTextNodesIn(el)
      foundStart = false
      charCount = 0
      i = 0
      while textNode = textNodes[i++]
        endCharCount = charCount + textNode.length
        if !foundStart && start>=charCount && (start < endCharCount || (start == endCharCount && i < textNodes.length))
          a = range.setStart(textNode, start - charCount)
          foundStart = true

        if foundStart && end <= endCharCount
          b = range.setEnd(textNode, end - charCount)
          break
        charCount = endCharCount

      nNd = document.createElement("span")
      nNd.setAttribute("id", annotation.uuid)
      nNd.style.color = annotation.color

      range.surroundContents(nNd)

  getTextNodesIn = (node) ->
    textNodes = []
    if node.nodeType == 3
      textNodes.push(node)
    else
      children = node.childNodes
      i=0
      len = children.length
      while i < len
        textNodes.push.apply(textNodes, getTextNodesIn(children[i]))
        ++i
    return textNodes

  #makeEditHightlight = (color)->
    #sel = window.getSelection()
    #if sel.rangeCount && sel.getRangeAt
      #range = sel.getRangeAt(0)

    #document.designMode = "on"

    #if range
      #sel.removeAllRanges()
      #sel.addRange(range)

    #if !document.execCommand("HiliteColor", false, color)
      #document.execCommand("BackColor", false, color)

    #document.designMode = "off"

