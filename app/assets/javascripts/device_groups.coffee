# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # collapse or uncollapse the menu for manual addition/removal of devices
  collapsed = false
  $('#btndevgroupsearch').click ->
    if collapsed is false
      collapsed = true
      $('#btndevgroupsearch').html('<span class="glyphicon glyphicon-collapse-up" aria-hidden="true"></span>')
      $('#btndevgroupsearch').removeClass('btn btn-primary').addClass('btn btn-warning')
    else
      collapsed = false
      $('#btndevgroupsearch').html('<span class="glyphicon glyphicon-search" aria-hidden="true"></span>')
      $('#btndevgroupsearch').removeClass('btn btn-warning').addClass('btn btn-primary')

  device_array = []
  devcnt = 0

  # add or remove a device to or from the device_array manually
  $('button.add-dev-group').click (event) ->
    devid = event.target.id
    if(devid == 'adddevgroup')
      devid = $('#devgroupbarcode').val()
      devid = parseInt(devid)
      if(devid > 86300000)
        devid = devid - 86324120
      $('#devgroupbarcode').val('')
    if gon.devices[devid] == undefined
      alert("Fehler: Ungültiges Gerät!")
      return true
    if(devid > 0)
      devid = parseInt(devid)
      # remove device from device_array
      if devid in device_array
        index = device_array.indexOf(devid)
        if(index != -1)
          devcnt--
          device_array.splice(index, 1)
          $('#' + devid).removeClass('btn btn-danger').addClass('btn btn-success')
          $('#' + devid).html('<span class="glyphicon glyphicon-plus-sign" aria-hidden="true">')
      # add device to device_array
      else
        devcnt++
        device_array.push(devid)
        $('#' + devid).removeClass('btn btn-success').addClass('btn btn-danger')
        $('#' + devid).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
    $('#seldevicegroups').empty()
    $('#devicegroupids').empty()
    $('#devicegroupids').val(device_array)
    $('#btndevgroupselection').html('Auswahl<span class="badge">' + devcnt + '</span>')
    for x in device_array
      $('#seldevicegroups').append('<li class="list-group-item">'+gon.devices[x].type + '(<strong>' + gon.devices[x].owner + '</strong>,' + gon.devices[x].stock + ')')

  # set already selected devices as selected
  $ ->
    try
      if gon.selected_devices?
        for i in gon.selected_devices
          i = parseInt(i)
          devcnt++
          device_array.push(i)
          $('#' + i).removeClass('btn btn-success').addClass('btn btn-danger')
          $('#' + i).html('<span class="glyphicon glyphicon-minus-sign" aria-hidden="true">')
        $('#seldevicegroups').empty()
        $('#devicegroupids').empty()
        $('#devicegroupids').val(device_array)
        $('#btndevgroupselection').html('Auswahl <span class="badge">' + devcnt + '</span>')
        for x in device_array
          $('#seldevicegroups').append('<li class="list-group-item">' + gon.devices[x].type + ' (<strong>' + gon.devices[x].owner + '</strong>, ' + gon.devices[x].stock + ')')