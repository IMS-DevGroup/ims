# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  collapsed = false
  #collapse or uncollapse the menu for manual addition/removal of devices
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

  #manually add or remove a device to or from the device_array
  $('button.add-dev').click (event) ->
    devid = event.target.id
    if(devid == 'adddev')
      devid = $('#barcode').val()
      devid = parseInt(devid)
      if(devid > 86300000)
        devid = devid - 86324120
      $('#barcode').val('')
    if gon.devices[devid] == undefined
      alert("Fehler: Ungültiges Gerät!")
      return true
    if(devid > 0)
      devid = parseInt(devid)
      #remove device from device_array
      if devid in device_array
        index = device_array.indexOf(devid)
        if(index != -1)
          devcnt--
          device_array.splice(index, 1)
          $('#' + devid).removeClass('btn btn-danger').addClass('btn btn-success')
          $('#' + devid).html('<span class="glyphicon glyphicon-plus-sign" aria-hidden="true">')
#add device to device_array
      else
        devcnt++
        device_array.push(devid)
        $('#' + devid).removeClass('btn btn-success').addClass('btn btn-danger')
        $('#' + devid).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
    $('#seldevices').empty()
    $('#deviceids').empty()
    $('#deviceids').val(device_array)
    $('#btnselection').html('Auswahl <span class="badge">' + devcnt + '</span>')
    for x in device_array
      $('#seldevices').append('<li class="list-group-item">' + gon.devices[x].type + ' (<strong>' + gon.devices[x].owner + '</strong>, ' + gon.devices[x].stock + ')')

  #autocomplete for user
  $('#tags').autocomplete
    source: gon.users
    appendTo: '#accompl'
    messages:
      noResults: ''
      results: ->

  #set already selected devices as selected
  $ ->
    try
    if gon.selected_devices?
      for i in gon.selected_devices
        i = parseInt(i)
        devcnt++
        device_array.push(i)
        $('#' + i).removeClass('btn btn-success').addClass('btn btn-danger')
        $('#' + i).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
      $('#seldevices').empty()
      $('#deviceids').empty()
      $('#deviceids').val(device_array)
      $('#btnselection').html('Auswahl <span class="badge">' + devcnt + '</span>')
      for x in device_array
        $('#seldevices').append('<li class="list-group-item">' + gon.devices[x].type + ' (<strong>' + gon.devices[x].owner + '</strong>, ' + gon.devices[x].stock + ')')



