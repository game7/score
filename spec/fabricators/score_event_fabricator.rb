Fabricator(:event, :class_name => Score::Event) do
  season
  venue
  starts Time.now
  duration 90
  end_type 'duration'
  summary 'Public Skating'
end

