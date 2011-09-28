Fabricator(:game, :class_name => Score::Game, :from => :event) do
  left_team { Fabricate(:team) }
  right_team { Fabricate(:team) }
end

