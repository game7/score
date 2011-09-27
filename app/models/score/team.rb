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

    referenced_in :division, class_name: "Score::Division"
    validates :division_id, :presence => true
    field :division_name, type: String
    field :division_slug, type: String
    before_save do |t|
      if d = t.division
        t.division_name = d.name
        t.division_slug = d.slug
      else
        t.division_name = t.division.slug = ""
      end
    end

    referenced_in :season, class_name: "Score::Season"
    validates :season_id, :presence => true
    field :season_name, type: String
    field :season_slug, type: String
    before_save do |t|
      if s = t.season
        t.season_name = s.name
        t.season_slug = s.slug
      else
        t.season_name = t.season.slug = ""
      end
    end

  end
end

