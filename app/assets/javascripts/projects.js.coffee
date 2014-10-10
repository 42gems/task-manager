#= require select2

$(document).on 'mouseenter', '.project', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'mouseleave', '.project', ->
  $(@).find('.badge').toggleClass 'hidden'
  $(@).find('.glyphicon-remove').toggleClass 'hidden'

$(document).on 'click', '.glyphicon-remove', (e) ->
  glyph = $(@)
  id = glyph.closest('.project').attr 'data-project-id'
  $.ajax(
    url: "/projects/" + id
    type: "POST"
    data:
      _method: "DELETE"
  ).done ->
      glyph.closest('a').remove()
      glyph.closest('.project').remove()
  e.preventDefault()

$(document).ready ->
  $("#select2").select2()

$(document).on 'click', '#invite_users', (e) ->
  email = $('.select2-chosen').html()
  option = $('#select2').find("option[email='#{email}']")
  user_id = $(option).attr 'value'
  url = $(option).attr('data-project-url')

  $.post url, (r) -> 
      option.remove()
      $('#select2').select2().val()
      $('#members').remove()
      $('#members_wrapper').append(r)

$(document).on 'click', '.remove_member', ->
  link = $(@)
  url = link.attr 'data-url'
  user_id = link.attr 'id'
  data = {
    _method: 'DELETE',
    user_id: user_id
  }
  $.post url, data, -> 
    link.closest('p').remove()
