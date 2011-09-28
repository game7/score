Fabricator(:event, :class_name => Score::Event) do
  season
  venue
  starts_on DateTime.now
  duration 90
  summary 'Public Skating'
end

