$(document).ready(function() {         
  $('nav li').hover(function() {
    $(this).hoverFlow('mouseenter', { marginTop: '-3px' }, 'fast');
  }, function() {
    $(this).hoverFlow('mouseleave', { marginTop: '0px' }, 'fast');
  });   
  
  $('nav li').click(function() {      
    var newClass = '#' + $(this).attr("class");
    var width = $(this).offset();  
    $('#bar').removeClass();
    $('#bar').addClass($(this).attr("class"));  
    $('#bar').animate().filter(':not(:animated)').animate({ "width": width.left }, 300);    
    if($(newClass).hasClass('active'))
    {
    } else {
      $('.phase_wrap.active').removeClass('active');
      $(newClass).addClass('active');
    }
  });
        
  $('.browse').hover(function() {   
    $(this).children('.arrow_hover').filter(':not(:animated)').animate({ opacity: '1.0', '-moz-opacity': '1.0' }, 300);
  }, function() {
    $(this).children('.arrow_hover').filter(':not(:animated)').animate({ opacity: '0.0', '-moz-opacity': '0.0' }, 300);
  });
  
  $('#me_twitter').hover(function() {  
    $('#me_twitter_bg_fade').animate({ opacity: '1.0', '-moz-opacity': '1.0' }, 300);
  }, function() {
    $('#me_twitter_bg_fade').filter(':not(:animated)').animate({ opacity: '0.0', '-moz-opacity': '0.0' }, 300);  
  });
  
  /*
  $('#dbd_twitter').hover(function() {  
    $(this).animate({ opacity: '1.0', '-moz-opacity': '1.0' }, 300);
  }, function() {
    $(this).filter(':not(:animated)').animate({ opacity: '0.6', '-moz-opacity': '0.6' }, 300);  
  });  
  
  $('#octocat').hover(function() {  
    $('#octocat_bg_fade').animate({ opacity: '1.0', '-moz-opacity': '1.0' }, 300);
  }, function() {
    $('#octocat_bg_fade').filter(':not(:animated)').animate({ opacity: '0.0', '-moz-opacity': '0.0' }, 300);  
  }); 
   
  
  $('#basic_details_form input').labelify();
	$('.form input:password').password123();
  
  if($('#basic_details_form')) 
  {
    $('#basic_details_form').ajaxForm({   
      dataType: 'json',
      success: signUpResponse
    });
  }     
  
  $('#sign_up').click(function() {   
    if($('#basic_details_form')) {
      $('#basic_details_form').trigger('submit'); 
    }
  });      
  
  function signUpResponse(jsonResp) 
  {       
    var errorMessage = '<div class="formResp ' + jsonResp.errorCode + '"<div class="message">' + jsonResp.message
                     + '</div><a href="#" class="closeMe">X</a></div>';    
    $('#signup').animate({ "opacity": 0.2 }, 300);    
    $(errorMessage).insertBefore('.steps');  
    $('#signup .closeMe').click(function() {
      $(this).parent().fadeOut(300).remove();   
      $('#signup').animate({ "opacity": 1.0 }, 300);  
    });
    if(jsonResp.errorCode != 'failure') {  
       $('#paypal_form').trigger('submit');   
    }  
  }        
  
  $("#basic_details_form").validationEngine({
		ajaxSubmit: false,
		"ajaxUser":{
    "file": "/accounts/checkexisting",
    "alertText":"* This e-mail is already registed",
    "alertTextOk":"* This e-mai is available",
    "alertTextLoad":"* Loading please wait"}, 
	});
      
  */
  
  $('.link_to_top').click(function() {
	  $.scrollTo('#top_header_wrap', 800, {easing:'easeInQuad'});
	});
	
  $('.projects_scroll').scrollable({circular: true, mousewheel: true}).navigator().autoscroll({
  	interval: 3000		
  });
  
});
              

Cufon.replace('h1, .project_title, .date', { fontFamily: 'Muse'});