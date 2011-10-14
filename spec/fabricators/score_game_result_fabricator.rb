Fabricator(:game_result, :class_name => Score::GameResult) do
  left_score rand(10)
  right_score rand(10)
  completed_in "regulation"
end
