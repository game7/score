Fabricator(:game, :class_name => Score::Game, :from => :event) do
  summary ""
  left_team { Fabricate(:team) }
  right_team { Fabricate(:team) }
end

