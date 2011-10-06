// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
	$('#team_season_id').change(function(){
		var season_id = $(this).val();
		if (season_id == "") {
			$('#team_division_id option').remove();
			var row = "<option value=\"\"></option>";
			$(row).appendTo('#team_division_id');
		} else {
			url = $('#team_divisions_path').val().replace('_id', season_id)
			$.ajax({
				dataType: "json",
				cache: false,
				url: url,
				timeout: 2000,
				error: function(XMLHttpRequest, errorTextStatus, error){
					alert("Failed to submit: " + errorTextStatus + ";" + error);
				},
				success: function(data){
					$('#team_division_id option').remove();
					var row = "<option value=\"\"></option>";
					$(row).appendTo('#team_division_id');
					$.each(data, function(i, j){
						row = "<option value=\"" + j._id + "\">" + j.name + "</option>";
						$(row).appendTo('#team_division_id');
					});
				}
			});
		}
	});
});

