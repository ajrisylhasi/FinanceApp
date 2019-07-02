# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#pesha_select').parent().hide() 
  peshas = $('#pesha_select').html()
  console.log(peshas)
  $("#article_select").change ->
    article = $("#article_select :selected").text()
    options = $(peshas).filter("optgroup[label='#{article}']").html()
    if options
      $('#pesha_select').html(options)
      $('#pesha_select').parent().show()
    else
      $('#pesha_select').empty()
      $('#pesha_select').parent().hide()      
      