Fabricator(:organization, :class_name => 'Score::Organization') do
  name  { %w{ desert-youth-hockey-association valley-of-the-sun-hockey-association arizona-hockey-union }.sample.humanize }
end
