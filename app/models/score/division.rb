module Score
  class Division
    include Mongoid::Document

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
    before_save do |t|
      update_season_info(self.season) if season_id_changed?
    end

    def update_season_info(s)
      unless s == nil
        self.season_name = s.name
        self.season_slug = s.slug
      else
        self.season_name = ""
        self.season_slug = ""
      end
    end

    references_many :teams, class_name: "Score::Team"

    scope :with_name, lambda { |name| where(:name => name) }
    scope :with_slug, lambda { |slug| where(:slug => slug) }
    
    class << self
      def for_season(season)
        season_id = ( season.class == Season ? season.id : season )
        where(:season_id => season_id)
      end
    end    

  end
end

