// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
  $('.tab-contents .tab[id != "tab1"]').hide();
  $('.tab-menu a').on('click', function(event) {
    $(".tab-contents .tab").hide();
    $(".tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});

$(document).on('turbolinks:load', function(){
	$('body').animate({
	  'opacity': 1
	}, 2000)
});

$(document).on('turbolinks:load', function(){
  $('#post_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

$(document).on('turbolinks:load', function(){
  $('#user_profile_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#profile-image-preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

$(document).on('turbolinks:load', function(){
  $('.menu-trigger').on('click', function(event) {
    event.preventDefault();
    $('.menu-trigger span').toggleClass('active');
    $('.side-bar').toggleClass('open');
  });
});

$(document).on('turbolinks:load', function(){
  $('.search-icon').on('click', function() {
    $(this).children('i').toggleClass('fas fa-search fa-2x');
    $(this).children('i').toggleClass('fas fa-times fa-2x');
    $('.search').toggle();
  });
});

$(document).on('turbolinks:load', function(){
  $('.post-content').on('mouseover', function(){
    $(this).find('.post-show-link').addClass('active');
    $(this).addClass('active');
  }).on('mouseout', function(){
    $(this).find('.post-show-link').removeClass('active');
    $(this).removeClass('active');
  });
});

$(document).on('turbolinks:load', function(){
  $('.follow-user-content').on('mouseover', function(){
    $(this).find('.user-show-link').addClass('active');
    $(this).addClass('active');
  }).on('mouseout', function(){
    $(this).find('.user-show-link').removeClass('active');
    $(this).removeClass('active');
  });
});

$(document).on('turbolinks:load', function(){
  $('.new-chat-button').on('click', function(event){
    event.preventDefault();
    $('.new-chat-form').toggle();
    if ($('.new-chat-button h5').text() === '新しくチャットを始める!!') {
    $('.new-chat-button h5').text('閉じる');
 　  } else {
    $('.new-chat-button h5').text('新しくチャットを始める!!');
    }
  });
});

$(document).on('turbolinks:load', function(){
  $('.rank-post-content').on('mouseover', function(){
    $(this).find('.rank-show-link').addClass('active');
    $(this).addClass('active');
  }).on('mouseout', function(){
    $(this).find('.rank-show-link').removeClass('active');
    $(this).removeClass('active');
  });
});