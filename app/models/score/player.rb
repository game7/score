class Score::Player
  include Mongoid::Document
  
  field :first, type: String
  validates :first, :presence => true
  
  field :last, type: String
  validates :last, :presence => true
  
  field :jersey_number, type: String
  
  belongs_to :team, class_name: "Score::Team"
  
end
