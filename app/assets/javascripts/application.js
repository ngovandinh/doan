// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ckeditor/init
//= require_tree .
//= require_tree ../../../vendor/customer/js/
//= require_tree ../../../vendor/admin/js/
//= require jquery.countdown
var countdown = function() {
  $('#clock').countdown({ //clock là thẻ chứa bộ đếm đồng hồ
    until: $('#remaining_time').val(), //thời gian đếm
    format: 'MS', //địn dạng thời gian
    onExpiry: function() {
      $('#button_finnish').hide(); //submit khi hết giờ
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
