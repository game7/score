// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  if( !$('#hockey_game_away_custom_name').attr('checked') ) { $('#hockey_game_away_team_name_input').hide() }
  if( !$('#hockey_game_home_custom_name').attr('checked') ) { $('#hockey_game_home_team_name_input').hide() }
  $('#hockey_game_away_custom_name').change(function(){ 
    $('#hockey_game_away_team_name_input').slideToggle('slow');
  });
  $('#hockey_game_home_custom_name').change(function(){ 
    $('#hockey_game_home_team_name_input').slideToggle('slow');
  });
});

function clear_division_dropdowns() {
  $("select[id$='division_id'] option").remove();
  var row = "<option value=\"" + "" + "\">" + "" + "</option>";
  $(row).appendTo("select[id$='division_id']");  
}
function clear_team_dropdown(home_or_away) {
  $("select[id$='"+home_or_away+"_team_id'] option").remove();
  var row = "<option value=\"" + "" + "\">" + "" + "</option>";
  $(row).appendTo("select[id$='"+home_or_away+"_team_id']");  
}

function load_division_dropdowns(season_id) {
  url = $('#divisions_path').val().replace('_season_id', season_id);
  $.ajax({
    dataType: "json",
    cache: false,
    url: url,
    timeout: 2000,
    error: function(XMLHttpRequest, errorTextStatus, error){
      alert("Failed to submit : "+ errorTextStatus+" ;"+error);
    },
    success: function(data){  
      $("select[id$='division_id'] option").remove();
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo("select[id$='division_id']"); 
      $.each(data, function(i, j){
        row = "<option value=\"" + j._id + "\">" + j.name + "</option>";
        $(row).appendTo("select[id$='division_id']");
      });
    }
  }); 
}

function load_team_dropdown(home_or_away, season_id, division_id) {
  url = $('#teams_path').val().replace('_season_id', season_id).replace('_division_id', division_id);
  $.ajax({
    dataType: "json",
    cache: false,
    url: url,
    timeout: 2000,
    error: function(XMLHttpRequest, errorTextStatus, error){
        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
    },
    success: function(data){
        $("select[id$='"+home_or_away+"_team_id option']").remove();
        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
        $(row).appendTo("select[id$='"+home_or_away+"_team_id']"); 
        $.each(data, function(i, j){
            row = "<option value=\"" + j._id + "\">" + j.name + " (" + j.division_name + " Division)</option>";
            $(row).appendTo("select[id$='"+home_or_away+"_team_id']");
        });
     }
  });
}

$(document).ready(function(){
  $("select#hockey_game_season_id").change(function(){
    var season_id = $(this).val();
    if (season_id == "") { 
      clear_division_dropdowns();
      clear_team_dropdown("home");
      clear_team_dropdown("away");
    } 
    else {
      load_division_dropdowns(season_id);
    } 
  });
  $("select#hockey_game_home_division_id").change(function(){
    var season_id = $('#hockey_game_season_id').val();
    var division_id = $(this).val();
    if (division_id == "") {
      clear_team_dropdown("home");
    }
    else {
      load_team_dropdown("home", season_id, division_id)
    }
  });
  $("select#hockey_game_away_division_id").change(function(){
    var season_id = $('#hockey_game_season_id').val();
    var division_id = $(this).val();
    if (division_id == "") {
      clear_team_dropdown("away");
    }
    else {
      load_team_dropdown("away", season_id, division_id)
    }
  });  
});
