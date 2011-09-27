module Score
  class Season
    include Mongoid::Document

      field :name, type: String
      validates :name, :presence => true

      field :slug, type: String

      field :starts_on, type: Date
      validates :starts_on, :presence => true

      scope :with_name, lambda { |name| where(:name => name) }
      scope :with_slug, lambda { |slug| where(:slug => slug) }

      references_many :teams, class_name: "Score::Team"

      class << self
        def most_recent
          where(:starts_on.lt => DateTime.now).desc(:starts_on).first
        end
        def latest
          desc(:starts_on).first
        end
      end

      before_validation do |s|
        s.slug = s.name.parameterize
      end

  end
end

