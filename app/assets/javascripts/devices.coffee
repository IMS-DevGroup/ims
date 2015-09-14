# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#device_device_type_id').change ->
    loadProperties()

$ ->
  try
    if gon.properties?
      loadProperties()

loadProperties = () ->
  if $('#device_device_type_id').val().length != 0
    $('#properties').empty()
    index = 0
    for x of gon.properties
      if parseInt($('#device_device_type_id').val()) == parseInt(gon.properties[x].device_type)
        if gon.properties[x].value == null
          switch gon.properties[x].data_type
            when "Fixnum" then input = '<div class="col-sm-6"><input type="text" placeholder="Please insert integer" pattern="^[0-9]+$" name="prop_val[' + index + ']"></div>'
            when "Float" then input = '<div class="col-sm-6"><input type="text" placeholder="Please insert float" pattern="^[0-9]+((.|,)[0-9]+){0,1}$" name="prop_val[' + index + ']"></div>'
            when "Boolean" then input = '<div class="col-sm-6"><input type="checkbox" name="prop_val[' + index + ']"></div>'
            when "Datetime" then input = '<div class="col-sm-6"><input type="text" class="form-control jsdatepicker" name="prop_val[' + index + ']" value="'+gon.value+'"></div>'
            else input = '<div class="col-sm-6"><input type="text" placeholder="Please insert string" name="prop_val[' + index + ']"></div>'
        else
          switch gon.properties[x].data_type
            when "Fixnum" then input = '<div class="col-sm-6"><input type="text" value="' + gon.properties[x].value + '" pattern="^[0-9]+$" name="prop_val[' + index + ']"></div>'
            when "Float" then input = '<div class="col-sm-6"><input type="text" value="' + gon.properties[x].value + '" pattern="^[0-9]+((.|,)[0-9]+){0,1}$" name="prop_val[' + index + ']"></div>'
            when "Boolean" then input = '<div class="col-sm-6"><input type="checkbox" name="prop_val[' + index + ']"></div>'
            when "Datetime" then input = '<div class="col-sm-6"><input type="text" class="form-control jsdatepicker" name="prop_val[' + index + ']" value="'+gon.value+'"></div>'
            else input = '<div class="col-sm-6"><input type="text" value="' + gon.properties[x].value + '" name="prop_val[' + index + ']"></div>'
        id = '<input type="hidden" name="prop_id[' + index + ']" value="' + gon.properties[x].id + '">'
        $('#properties').append('<tr height=35><td>' + gon.properties[x].name + '</td><td>' + input + id + '</td></tr>')
        $('.jsdatepicker').datetimepicker({defaultDate: new Date().getTime()})
        index = index + 1