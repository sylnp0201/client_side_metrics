# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $container = $("#container")

  chart_title = 'Bloomberg.com Beta Site Page Load Performance'
  data = JSON.parse $container.attr('data-result')
  first_view  = data.first_view
  repeat_view = data.repeat_view

  time_stamps = []
  graph_series = []
  $.each(first_view, (idx, node) ->
    d = new Date(node[0])
    time_stamps.push("#{d.getMonth()}/#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}")
  )
  $.each(data.fields, (idx, field) ->
    data_series = $.map(data.first_view, (node) ->
      node[1][field]/1000
    )
    s = {name: field, data: data_series}
    graph_series.push(s)
  )

  $container.highcharts
    title:
      text: chart_title
      x: -20 #center

    subtitle:
      text: "Browser: #{data.browser}, Location: #{data.location}, Page: #{data.page}"
      x: -20

    xAxis:
      categories: time_stamps

    yAxis:
      title:
        text: "Seconds"

      plotLines: [
        value: 0
        width: 1
        color: "#808080"
      ]

    tooltip:
      valueSuffix: "s"

    legend:
      layout: "vertical"
      align: "right"
      verticalAlign: "middle"
      borderWidth: 0

    series: graph_series

