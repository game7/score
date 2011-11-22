Fabricator(:hockey_game_result, :class_name => Score::HockeyGameResult) do
  home_score rand(10)
  away_score rand(10)
  completed_in "regulation"
end
