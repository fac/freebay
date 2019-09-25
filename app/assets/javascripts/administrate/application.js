//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .
//= require semantic-ui

$(document).ready(function() {
  $('#toggle_archived').change(function(e) {
    const params = new URLSearchParams(location.search)
    params.set("show_archived", e.target.checked)
    location.search = params.toString();
  });
});
