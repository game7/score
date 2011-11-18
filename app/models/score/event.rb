module Score
  class Event
    include Mongoid::Document
    
    field :starts, type: Time
    field :duration, type: Integer
            
    validates :starts, :presence => true
    validates :duration, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }    

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

    before_save :cleanup_division_ids
    def cleanup_division_ids
      division_ids.collect! { |id| BSON::ObjectId(id.to_s) }
      division_ids.uniq!
    end

    scope :in_the_past, :where => { :starts.lt => DateTime.now }
    scope :in_the_future, :where => { :ends.gt => DateTime.now }
    scope :from, lambda { |from| { :where => { :starts.gt => from } } }
    scope :to, lambda { |to| { :where => { :starts.lt => to } } }
    scope :between, lambda { |from, to| { :where => { :starts.gt => from, :starts.lt => to } } }
    class << self
      def for_team(t)
        id = t.class == Team ? t.id : t
        any_of( { :team_ids => t.id}, { :division_ids => t.division_id, :show_for_all_teams => true })
      end
      def for_season(s)
        id = s.class == Season ? s.id : s
        where(:season_id => id)
      end
      def for_division(d)
        id = d.class == Division ? d.id : d
        any_in( :division_ids => [id])
      end
    end

  end
end

