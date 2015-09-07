# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#device_device_type_id').change ->
    $.ajax
      url: '/get-prop'
      type: 'POST'
      dataType: 'json'
      data: {
        device_type: $('#device_device_type_id').val()
      }
      success: (data) ->
        $('#properties').empty()
        $.each data.result, (index, value) ->
          $('#properties').append("<option>" + value + "</option>")
          return
        $('#properties').show()
        return
      error: (request, error) ->
        alert 'Request: ' + JSON.stringify(request)
        return