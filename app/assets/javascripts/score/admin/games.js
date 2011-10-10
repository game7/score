// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  if( !$('#game_left_custom_name').attr('checked') ) { $('#game_left_name_input').hide() }
  if( !$('#game_right_custom_name').attr('checked') ) { $('#game_right_name_input').hide() }
  $('#game_left_custom_name').change(function(){ 
    $('#game_left_name_input').slideToggle('slow');
  });
  $('#game_right_custom_name').change(function(){ 
    $('#game_right_name_input').slideToggle('slow');
  });
});
$(document).ready(function(){
    $("select#game_season_id").change(function(){
        var season_id = $(this).val();
        if (season_id == "") { 
            // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
            $("select[id$='team_id'] option").remove();
            var row = "<option value=\"" + "" + "\">" + "" + "</option>";
            $(row).appendTo("select[id$='team_id']");
        }
        else {
          url = $('#teams_path').val().replace('_season_id', season_id);
          $.ajax({
              dataType: "json",
              cache: false,
              url: url,
              timeout: 2000,
              error: function(XMLHttpRequest, errorTextStatus, error){
                  alert("Failed to submit : "+ errorTextStatus+" ;"+error);
              },
              success: function(data){  
                  $("select[id$='team_id'] option").remove();
                  var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                  $(row).appendTo("select[id$='team_id']"); 
                  $.each(data, function(i, j){
                      row = "<option value=\"" + j._id + "\">" + j.name + " (" + j.division_name + " Division)</option>";
                      $(row).appendTo("select[id$='team_id']");
                  });
               }
          });
        };
    });
});