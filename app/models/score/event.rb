module Score
  class Event
    include Mongoid::Document

    field :starts_on, type: DateTime
    validates :starts_on, :presence => true
    before_validation do |e|
      # set hour to 12:00 AM for all day events
      self.starts_on = self.starts_on.change(:hour => 0) if self.all_day
    end

    field :ends_on, type: DateTime
    validates :ends_on, :presence => true
    before_validation do |e|
      if all_day
        self.ends_on = starts_on.change(:hour => 0).change(:day => starts_on.day + 1)
      else
        self.ends_on = starts_on.advance(:minutes => duration)
      end
    end

    field :duration, type: Integer
    validates :duration, :presence => true, :numericality => true
    before_validation do |e|
      self.duration = 24 * 60 if all_day
    end

    field :all_day, type: Boolean

    field :summary, type: String
    validates :summary, :presence => true

    field :description, type: String

    referenced_in :season, :class_name => 'Score::Season'
    validates :season_id, :presence => true

    referenced_in :venue, :class_name => 'Score::Venue'
    field :venue_name, type: String
    field :venue_short_name, type: String

    field :division_ids, type: Array, default: []
    field :team_ids, type: Array, default: []
    field :show_for_all_teams, type: Boolean

    before_save do |e|
      update_venue_info(self.venue) if venue_id_changed?
    end

    def update_venue_info(v)
      unless v == nil
        self.venue_name = v.name
        self.venue_short_name = v.short_name
      else
        self.venue_name = ""
        self.venue_short_name = ""
      end
    end

  end
end

