# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  device_array = []
  $('button').click (event) ->
    devid = event.target.id
    if(devid == 'adddev')
      devid = $('#barcode').val()
    if(devid>0)
      if devid in device_array
        index = device_array.indexOf(devid)
        if(index != -1)
          device_array.splice(index, 1)
          $('#'+devid).removeClass('btn btn-danger').addClass('btn btn-success')
          $('#'+devid).html('<span class="glyphicon glyphicon-plus-sign" aria-hidden="true">')
      else
        device_array.push(devid)
        $('#'+devid).removeClass('btn btn-success').addClass('btn btn-danger')
        $('#'+devid).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
    $('#seldevices').empty()
    $('#seldevices').append(device_array)


