jQuery ->
  $('#aricle_location_id').parent().hide()
  locations = $('#aricle_location_id').html()
  $('#aricle_city_id').change ->
    city = $('#aricle_city_id :selected').text()
    escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(locations).filter("optgroup[label='#{escaped_city}']").html()
    if options
      $('#aricle_location_id').html(options)
      $('#aricle_location_id').parent().show()
    else
      $('#aricle_location_id').empty()
      $('#aricle_location_id').parent().hide()
