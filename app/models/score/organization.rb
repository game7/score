module Score
  class Organization
    include Mongoid::Document
    
    field :name, type: String
    validates :name, :presence => true

    field :slug, type: String
    validates :slug, :presence => true

    before_validation do |c|
      c.slug = c.name.parameterize
    end

    has_many :teams, class_name: "Score::Team"
  
  end
end