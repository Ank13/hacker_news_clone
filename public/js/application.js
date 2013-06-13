$(document).ready(function() {

  $('.vote-form').css({ "position" : "absolute", "right" : "-9999px" });
  
  // send AJAX request on vote button click
  $('span.vote-post').on('click', function( event ) {
    event.preventDefault();
    var $arrow = $(this);
    $arrow.css({ "position" : "relative", "right" : "-9999px" });
    var postData = $arrow.closest('.post').find('.vote-form').serialize();
    $.post('/postvote', postData, function(response) {
        $arrow.closest('li').html(response);
    }); 
  });


  $('span.vote-comment').on('click', function( event ) {
    event.preventDefault();
    var $arrow = $(this);
    $arrow.css({ "position" : "relative", "right" : "-9999px" });
    var postData = $arrow.closest('.comment').find('.vote-form').serialize();
    $.post('/commentvote', postData);
  });


});
