# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org

$(window).load ->
  $('.container').find('img').each ->
    imgClass = if @width / @height > 1 then 'wide' else 'tall'
    $(this).addClass imgClass
    return
  return