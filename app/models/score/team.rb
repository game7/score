module Score
  class Team
    include Mongoid::Document
    before_save :ensure_record
    before_save :ensure_logo
    before_save do |t|
      update_division_info(self.division) if division_id_changed?
    end
    before_save do |t|
      update_organization_info(self.organization)
    end
    before_validation do |t|
      t.short_name ||= t.name
      t.slug = t.name.parameterize if t.name
    end        

    field :name, type: String
    validates :name, :presence => true

    field :short_name, type: String
    validates :short_name, :presence => true

    field :slug, type: String
    validates :slug, :presence => true

    field :show_in_standings, type: Boolean, default: true

    belongs_to :organization, class_name: "Score::Organization"
    field :organization_name, type: String
    field :organization_slug, type: String
    
    has_many :players, class_name: "Score::Player", dependent: :destroy    

    referenced_in :division, class_name: "Score::Division"
    validates :division_id, :presence => true
    field :division_name, type: String
    field :division_slug, type: String

    referenced_in :season, class_name: "Score::Season"
    field :season_name, type: String
    field :season_slug, type: String
    
    embeds_one :record, class_name: "Score::TeamRecord"
    
    embeds_one :logo, class_name: "Score::Logo", as: :logoable
    
    def has_logo?
      logo.present? && logo.image.present? && logo.image.url.present?
    end
    
    def update_division_info(d)
      unless d == nil
        self.division_name = d.name
        self.division_slug = d.slug
        self.season_id = d.season_id
        s = d.season
        self.season_name = s.name
        self.season_slug = s.slug
      else
        self.division_name = ""
        self.division_slug = ""
        self.season_id = nil
        self.season_name = ""
        self.season_slug = ""
      end
    end
    
    def update_organization_info(o)
      unless o == nil
        self.organization_name = o.name
        self.organization_slug = o.slug
      else
        self.organization_name = ""
        self.organization_slug = ""
      end
    end
    
    class << self
      def for_season(season)
        season_id = ( season.class == Season ? season.id : season )
        where(:season_id => season_id)
      end
      def for_division(division)
        division_id = ( division.class == Division ? division.id : division )
        where(:division_id => division_id)
      end
    end
    
    private
    
      def ensure_record
        self.record ||= Score::TeamRecord.new
      end
      
      def ensure_logo
        self.logo ||= Score::Logo.new
      end

  end
end

