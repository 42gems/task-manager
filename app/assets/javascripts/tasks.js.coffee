#= require jquery-ui/draggable
#= require jquery-ui/droppable

$(document).ready ->
  $('.datetimepicker').datetimepicker()

$(document).on 'mouseenter', '.task', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'mouseleave', '.task', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'click', '.glyphicon-remove', (e) ->
  task = $(@).closest('.task')
  url = task.attr 'data-url'
  $.ajax(
    url: url
    type: "POST"
    data:
      _method: "DELETE"
  ).done ->
      task.remove()
  e.preventDefault()

$(document).ready ->
  $('.task').draggable
    containment: '.tasks'
    start: ->
      $(@).css { zIndex: 99 }
    stop: ->
      $(@).css { zIndex: 1 }

  $('.list').droppable
    drop: (e, ui) ->
      task = ui.draggable
      task.detach().appendTo(@).css { top: 0, left: 0 }

      url = task.attr 'data-url'
      state = $(@).attr 'data-state'
      data = {
        _method: 'PATCH',
        task:
          state: state
      }
      $.post(url, data)
