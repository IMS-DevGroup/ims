# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#devices').dataTable()

$ ->
  $('#device_device_type_id').change ->
    if $('#device_device_type_id').val().length != 0 then $ ->
      $.ajax
        url: '/get-prop'
        type: 'POST'
        dataType: 'JSON'
        data: {
          device_type: $('#device_device_type_id').val()
        }
        success: (data) ->
          $('#properties').empty()
          $.each data.result, (index, value) ->
            textfield = '<input type="text" id="prop' + index + '">'
            $('#properties').append('<tr height=35><td>' + value.name + '</td><td>' + textfield + '</td></tr>')
            return
          return
        error: (request, error) ->
          alert 'Request: ' + JSON.stringify(request)
          return
    else $('#properties').empty()

$ ->
  $('#submit').click ->
    for i in [0...index]
      console.log(value.id)
      $.ajax
        url: '/set-val'
        type: 'POST'
        dataType: 'JSON'
        data: {
          prop_value: $('#prop' + i + '').val() value.id $('#device_id')
        }