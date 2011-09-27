Fabricator(:team, :class_name => Score::Team) do
  name "New Team"
  short_name "Team"
  show_in_standings true
  division
  season
end

