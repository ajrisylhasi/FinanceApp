# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#normative_select').parent().hide() 
  normatives = $('#normative_select').html()
  $("#product_select").change ->
    product = $("#product_select :selected").text()
    options = $(normatives).filter("optgroup[label='#{product}']").html()
    if options
      $('#normative_select').html(options)
      $('#normative_select').parent().show()
    else
      $('#normative_select').empty()
      $('#normative_select').parent().hide()      
      