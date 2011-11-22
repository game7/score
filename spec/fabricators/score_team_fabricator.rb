Fabricator(:team, :class_name => Score::Team) do
  name { %w(Ducks Kings Sharks Avalanche Coyotes Blues Blackhawks Stars Canucks Jets Oilers Flames).sample }
  short_name { |team| team.name }
  show_in_standings true
  division
end

