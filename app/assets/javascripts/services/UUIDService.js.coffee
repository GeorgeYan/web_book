angular.module('web_book').factory 'UUID', ->
  return {
    newuuid: ->
      d = new Date().getTime()
      uuid = 'xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, c = ->
        r = (d + Math.random()*16)%16| 0
        d = Math.floor(d/16)
        return (if c=='x' then r else  (r&0x7|0x8)).toString(16)
      )
      return uuid
  }
