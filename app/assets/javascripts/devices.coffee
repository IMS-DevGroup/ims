# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
values = []

$ ->
  $('#devices').dataTable()
  $('#switch').bootstrapSwitch('offText', '<span class="flag-icon flag-icon-de"></span>')
  $('#switch').bootstrapSwitch('onText', '<span class="flag-icon flag-icon-gb"></span>')
  $('#switch').bootstrapSwitch('offColor', 'primary')
  $('#switch').on("switchChange.bootstrapSwitch",
    (e, state) ->
      if $(e.target).data("cur_lang") == 'de'
        window.location.href = '/set_language/english'
      else
        window.location.href = '/set_language/german'
  )

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
            window.index = index
            values.push value.id
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
    for i in [0...index + 1]
      $.ajax
        url: '/set-val'
        type: 'POST'
        dataType: 'JSON'
        data: {
          prop_val: $('#prop' + i + '').val()
          prop_id: values[i]
        }