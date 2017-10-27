$(document).ready(function(){
  disableSearchButton();
});

function disableSearchButton(){
  $('#button').prop('disabled', true);

  $('#search-bar').on('change paste keyup', function() {
    if($(this).val().length > 0){
      $('#button').prop('disabled', false);
    } else {
      $('#button').prop('disabled', true);
    }
  });
}

