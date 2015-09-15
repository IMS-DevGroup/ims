# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  collapsed = false
  $('#btnsearch').click ->
    if collapsed is false
      collapsed = true
      $('#btnsearch').html('<span class="glyphicon glyphicon-collapse-up" aria-hidden="true"></span>')
      $('#btnsearch').removeClass('btn btn-primary').addClass('btn btn-warning')
    else
      collapsed = false
      $('#btnsearch').html('<span class="glyphicon glyphicon-search" aria-hidden="true"></span>')
      $('#btnsearch').removeClass('btn btn-warning').addClass('btn btn-primary')
  device_array = []
  devcnt = 0
  $('button.add-dev').click (event) ->
    devid = event.target.id
    if(devid == 'adddev')
      devid = $('#barcode').val()
      devid = parseInt(devid)-86324120
      $('#barcode').val('')
    if gon.devices[devid] == undefined
      alert("Fehler: Ungültiges Gerät!")
      return true
    if(devid>0)
      devid = parseInt(devid)
      if devid in device_array
        index = device_array.indexOf(devid)
        if(index != -1)
          devcnt--
          device_array.splice(index, 1)
          $('#'+devid).removeClass('btn btn-danger').addClass('btn btn-success')
          $('#'+devid).html('<span class="glyphicon glyphicon-plus-sign" aria-hidden="true">')
      else
        devcnt++
        device_array.push(devid)
        $('#'+devid).removeClass('btn btn-success').addClass('btn btn-danger')
        $('#'+devid).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
    $('#seldevices').empty()
    $('#deviceids').empty()
    $('#deviceids').val(device_array)
    $('#btnselection').html('Auswahl <span class="badge">'+ devcnt + '</span>')
    for x in device_array
      $('#seldevices').append('<li class="list-group-item">'+gon.devices[x].type+' (<strong>'+gon.devices[x].owner+'</strong>, '+gon.devices[x].stock+')')


  $ ->
    for i in gon.selected_devices
      i = parseInt(i)
      devcnt++
      device_array.push(i)
      $('#'+i).removeClass('btn btn-success').addClass('btn btn-danger')
      $('#'+i).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
    $('#seldevices').empty()
    $('#deviceids').empty()
    $('#deviceids').val(device_array)
    $('#btnselection').html('Auswahl <span class="badge">'+ devcnt + '</span>')
    for x in device_array
      $('#seldevices').append('<li class="list-group-item">'+gon.devices[x].type+' (<strong>'+gon.devices[x].owner+'</strong>, '+gon.devices[x].stock+')')



