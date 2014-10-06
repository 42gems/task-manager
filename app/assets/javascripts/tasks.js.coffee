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