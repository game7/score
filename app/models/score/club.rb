module Score
  class Club
    include Mongoid::Document

    field :name, type: String
    validates :name, :presence => true

    field :short_name, type: String
    validates :short_name, :presence => true

    before_validation do |c|
      c.short_name ||= c.name
    end

    field :slug, type: String
    validates :slug, :presence => true

    before_validation do |c|
      c.slug = c.name.parameterize
    end

    references_many :teams, class_name: "Score::Team"

  end
end

