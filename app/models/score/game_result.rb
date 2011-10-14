module Score
  class GameResult
    include Mongoid::Document  
    
    embedded_in :game, class_name: 'Score::Game'
    
    field :left_score, type: Integer
    validates :left_score, presence: true, numericality: true
    
    field :right_score, type: Integer
    validates :right_score, presence: true, numericality: true
    
    field :completed_in, type: String
    validates :completed_in, presence: true
    
    COMPLETED_IN = %w[regulation overtime shootout forfeit]
    def self.completed_in_options
      COMPLETED_IN.collect{ |o| [o.humanize, o] }
    end
    
  end
end
