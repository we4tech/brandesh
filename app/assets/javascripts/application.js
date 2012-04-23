// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require ../../../vendor/assets/javascripts/jqueryui/jquery-ui.min.js
//= require ../../../vendor/assets/javascripts/modernizr/modernizr-2.5.3.min.js
//= require ../../../vendor/assets/javascripts/modernizr/bootstrap.min.js
//= require ../../../vendor/assets/javascripts/modernizr/plugins.js
//= require ../../../vendor/assets/javascripts/modernizr/script.js
//= require_tree .

jQuery(document).ready(function(){
  $('.tabs_container').tabs();

  $('.date_fields').datepicker();
})