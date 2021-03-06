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

jQuery(document).ready(function () {
  $('.tabs_container').tabs({
    selected: 0
  });

  $('.date_fields').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  jQuery('a[tab-autoswitch]').each(function () {
    var self = $(this);
    self.click(function () {
      jQuery(self.attr('href') + '_tab').tab('show');
    });

  });

  jQuery('.remote-form').remoteForm();

  // Bind submit event for agency form
  jQuery('#new_user').bind('submit', function () {
    if ('none' == $('#agency_form').css('display')) {
      $('#agency_form').remove();
    }
  });

  // Show description when category is selected
  jQuery('#project_category_id').bind('change', function (e) {
    try {
      $('#category-description').html(categoriesDescription[e.currentTarget.selectedIndex]);
    } catch (e) {
      alert(e);
    }
  });

  // Load initial description
  if ($('#category-description').length > 0)
    $('#category-description').html(categoriesDescription[jQuery('#project_category_id')[0].selectedIndex]);

  // Choose credits based on media type
  $('#project_media_type_id').bind('change', function(e) {
    $('.credits_panel').hide();
    $($('.credits_panel')[e.currentTarget.selectedIndex]).show();
  });

  // Load default credits
  if ($('.credits_panel').length > 0) {
    $($('.credits_panel')[$('#project_media_type_id')[0].selectedIndex]).show();
  }

  // Remove unused credits during submission
  $('#new_project, #edit_project').bind('submit', function() {
    $('.credits_panel').each(function() {
      var $el = $(this);
      if ($el.css('display') == 'none') {
        $el.remove();
      }
    });
  });

  // Determine currently active tab
  $('.navbar .nav li a').each(function() {
    var el = $(this);
    var urlParts = window.location.href.split('/');
    var lastPart = urlParts[urlParts.length - 1];

    if (el.text().toLowerCase().indexOf(lastPart) != -1) {
      el.parent().addClass('active');
    }
  });
});

// Register Remote form on error related handlers
function RemoteForm_onError($el, msg) {
  $el.find('.notice').html(
      "<div class='alert alter-warning'>" + msg +
          "<button type='button' class='close' data-dismiss='alert'>×</button>" +
          '</div>');
  $el.find('.notice').show();
}

function _log(msg) {
  if ('undefined' != typeof(console)) {
    console.log(msg);
  }
}

// Register remote form data receiving related handler
function RemoteForm_onData($el, json) {
  _log(json);

  if (json && json.length > 0) {
    var agency = json[0];

    if (confirm('Do you want to be enlisted under `' + agency.name + '` ?')) {
      var html = "<fieldset class='alert alert-success'>" +
          "<a class='close' data-dismiss='alert' href='#'>×</a>" +
          "<h5>" +
          "You are associated with <b>`" + agency.name + "`</b>" +
          "<input type='hidden' name='user[agency_ids][]' " +
          "value='" + agency.id + "'/>" +
          "</h5></fieldset>";

      _log(html);
      $('#agency_selection_info').html(html);
      $('#agency_form').hide();
    }
  } else {
    if (confirm("Sorry couldn't find an existing record.\nDo you want to create new ?")) {
      //$('#agency_form').withInForm($('#agency-form-placeholder'));
      $('#agency_form').show();
      $('#agency_selection_info').html('');
      window.location = window.location.href.split('#')[0] + '#agency_form';
    }
  }
}