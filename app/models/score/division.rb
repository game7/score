module Score
  class Division
    include Mongoid::Document
    
    before_save :update_season_info, :if => :season_id_changed?
    before_save :update_team_count

    field :name, type: String
    validates :name, :presence => true

    field :slug, type: String
    validates :slug, :presence => true

    before_validation do |d|
      d.slug = d.name.parameterize
    end

    referenced_in :season, class_name: "Score::Season"
    validates :season_id, :presence => true
    field :season_name, type: String
    field :season_slug, type: String

    references_many :teams, class_name: "Score::Team"
    field :team_count, type: Integer, default: 0
    attr_protected :team_count

    scope :with_name, lambda { |name| where(:name => name) }
    scope :with_slug, lambda { |slug| where(:slug => slug) }
    
    class << self
      def for_season(season)
        season_id = ( season.class == Season ? season.id : season )
        where(:season_id => season_id)
      end
    end

    def team_created
      self.team_count += 1
    end
    
    def team_destroyed
      self.team_count -= 1
    end
    
    private
    
      def update_season_info
        if s = self.season
          self.season_name = s.name
          self.season_slug = s.slug
        else
          self.season_name = ""
          self.season_slug = ""
        end        
      end
      
      def update_team_count
        self.team_count = self.teams.count
      end

  end
end

