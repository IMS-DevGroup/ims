# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
            switch value.data_type_id
              when 2 then input = '<div class="col-sm-6"><input type="text" placeholder="Please insert float" pattern="^[0-9]+((.|,)[0-9]+){0,1}$" name="prop_val[' + index + ']"></div>'
              when 3 then input = '<div class="col-sm-6"><input type="text" class="form-control jsdatepicker" name="prop_val[' + index + ']"></div>'
              when 4 then input = '<div class="col-sm-6"><input type="checkbox" name="prop_val[' + index + ']"></div>'
              when 5 then input = '<div class="col-sm-6"><input type="text" placeholder="Please insert integer" pattern="^[0-9]+$" name="prop_val[' + index + ']"></div>'
              else input = '<div class="col-sm-6"><input type="text" placeholder="Please insert string" name="prop_val[' + index + ']"></div>'
            id = '<input type="hidden" name="prop_id[' + index + ']" value="' + value.id + '">'
            $('#properties').append('<tr height=35><td>' + value.name + '</td><td>' + input + id + '</td></tr>')
            $('.jsdatepicker').datetimepicker({ defaultDate: new Date().getTime() })
            return
          return
        error: (request, error) ->
          alert 'Request: ' + JSON.stringify(request)
          return
    else $('#properties').empty()

