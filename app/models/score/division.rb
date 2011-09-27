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

    references_many :teams, class_name: "Score::Team"

    scope :with_name, lambda { |name| where(:name => name) }
    scope :with_slug, lambda { |slug| where(:slug => slug) }

  end
end

