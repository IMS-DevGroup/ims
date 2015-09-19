# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # load properties when dropdown entry is changed
  $('#device_device_type_id').change ->
    loadProperties()

$ ->
  # load properties when device is editing
  try
    if gon.properties?
      loadProperties()

# method to load all properties from the chosen device type
loadProperties = () ->
  if $('#device_device_type_id').val().length != 0
    # clear table when change it
    $('#properties').empty()
    i = 0
    for p of gon.properties
      if parseInt($('#device_device_type_id').val()) == parseInt(gon.properties[p].device_type)
        # true, if device is editing, false otherwise
        if gon.properties[p].value != null
          switch gon.properties[p].data_type
            when "Fixnum" then input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" value="' + gon.properties[p].value + '" pattern="^[0-9]+$" required>' +
              '</div>'
            when "Float" then input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" value="' + gon.properties[p].value + '" pattern="^[0-9]+((.|,)[0-9]+){0,1}$" required>' +
              '</div>'
            when "Boolean"
              if gon.properties[p].value == 'on' then input =
                '<div class="col-sm-6">' +
                  '<input type="hidden" name="prop_val[' + i + ']" value="false">' +
                  '<input type="checkbox" name="prop_val[' + i + ']" checked>' +
                '</div>'
              else input =
                '<div class="col-sm-6">' +
                  '<input type="hidden" name="prop_val[' + i + ']" value="false">' +
                  '<input type="checkbox" name="prop_val[' + i + ']">' +
                '</div>'
            when "Datetime" then input =
              '<div class="col-sm-6">' +
                '<input type="text" class="form-control jsdatepicker" name="prop_val[' + i + ']" value="' + gon.properties[p].value + '">' +
              '</div>'
            when "DateNote" then input =
              '<div class="col-sm-6">' +
                '<input type="text" class="form-control jsdatepicker" name="prop_val[' + i + ']" value="' + gon.properties[p].value + '">' +
              '</div>'
            else input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" value="' + gon.properties[p].value + '" required>' +
              '</div>'
        else
          switch gon.properties[p].data_type
            when "Fixnum" then input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" placeholder="Please insert integer" pattern="^[0-9]+$" required>' +
              '</div>'
            when "Float" then input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" placeholder="Please insert float" pattern="^[0-9]+((.|,)[0-9]+){0,1}$" required>' +
              '</div>'
            when "Boolean" then input =
              '<div class="col-sm-6">' +
                '<input type="hidden" name="prop_val[' + i + ']" value="false">' +
                '<input type="checkbox" name="prop_val[' + i + ']" value="on">' +
              '</div>'
            when "Datetime" then input =
              '<div class="col-sm-6">' +
                '<input type="text" class="form-control jsdatepicker" name="prop_val[' + i + ']">' +
              '</div>'
            when "DateNote" then input =
              '<div class="col-sm-6">' +
                '<input type="text" class="form-control jsdatepicker" name="prop_val[' + i + ']">' +
              '</div>'
            else input =
              '<div class="col-sm-6">' +
                '<input type="text" name="prop_val[' + i + ']" placeholder="Please insert string" required>' +
              '</div>'
        # hidden identifier for each property
        hidden = '<input type="hidden" name="prop_id[' + i + ']" value="' + gon.properties[p].id + '">'
        $('#properties').append('<tr height=35><td>' + gon.properties[p].name + '</td><td>' + input + hidden + '</td></tr>')
        # initializer for datetimepicker
        $('.jsdatepicker').datetimepicker({format: 'YYYY-MM-DD',defaultDate: new Date().getTime() })
        i = i + 1