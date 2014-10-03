$(document).on 'mouseenter', '.project', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'mouseleave', '.project', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'click', '.glyphicon-remove', (e) ->
  id = $(@).closest('.project').attr 'data-project-id'
  proj = $(@)
  $.ajax(
    url: "/projects/" + id
    type: "POST"
    data:
      _method: "DELETE"
  ).done ->
      proj.closest('a').remove()
      proj.closest('.project').remove()
  e.preventDefault()