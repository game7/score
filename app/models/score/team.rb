module Score
  class Team
    include Mongoid::Document

    field :name, type: String
    validates :name, :presence => true

    field :short_name, type: String
    validates :short_name, :presence => true

    field :slug, type: String
    validates :slug, :presence => true

    field :show_in_standings, type: Boolean

    before_validation do |t|
      t.short_name ||= t.name
      t.slug = t.name.parameterize
    end

    referenced_in :club, class_name: "Score::Club"

    referenced_in :division, class_name: "Score::Division"
    validates :division_id, :presence => true
    field :division_name, type: String
    field :division_slug, type: String
    before_save do |t|
      update_division_info(self.division) if division_id_changed?
    end

    def update_division_info(d)
      unless d == nil
        self.division_name = d.name
        self.division_slug = d.slug
      else
        self.division_name = ""
        self.division_slug = ""
      end
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

  end
end

