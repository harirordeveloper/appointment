jQuery ->
  $('#location_name').autocomplete
    source: $('#location_name').data('autocomplete-source')
