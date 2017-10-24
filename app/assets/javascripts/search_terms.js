$(document).ready(function(){
  disableSearchButton();
  inputValue();
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

function inputValue() {
  $(".term").click(function(){
    const term = $(this).text();
    $('#search-bar').val($.trim(term));
    $('#button').prop('disabled', false);
  });
}
