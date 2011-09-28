module Score
  class Venue
    include Mongoid::Document

    field :name, type: String
    validates :name, :presence => true

    field :short_name, type: String
    validates :short_name, :presence => true

    before_validation do |t|
      t.short_name ||= t.name
    end

  end
end

