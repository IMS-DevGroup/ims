#=require jquery
#=require jquery_ujs
#=require dataTables/jquery.dataTables
#= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
#= require dataTables/jquery.dataTables

#= require_tree .
#= require bootstrap-sprockets
#= require bootstrap-switch
#= require moment
#= require bootstrap-datetimepicker


$ ->
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

