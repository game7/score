Fabricator(:hockey_game, :class_name => Score::HockeyGame, :from => :event) do
  summary ""
  home_division { Fabricate(:division) }
  home_team { |hockey_game| Fabricate(:team, :division => hockey_game.home_division) }
  away_division { Fabricate(:division) }
  away_team { |hockey_game| Fabricate(:team, :division => hockey_game.away_division) } 
end
