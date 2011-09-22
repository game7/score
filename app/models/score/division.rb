module Score
  class Division
    include Mongoid::Document

    field :name, type: String
    validates :name, :presence => true

    field :slug, type: String

    scope :with_name, lambda { |name| where(:name => name) }
    scope :with_slug, lambda { |slug| where(:slug => slug) }

    before_save do |d|
      d.slug = d.name.parameterize
    end

  end
end
