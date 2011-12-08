module Score
  class HockeyGameResult
    include Mongoid::Document
  
    embedded_in :game, class_name: 'Score::HockeyGame'
  
    field :home_score, type: Integer
    validates :home_score, presence: true, numericality: true
  
    field :away_score, type: Integer
    validates :away_score, presence: true, numericality: true
  
    field :final?, type: Boolean
  
    field :completed_in, type: String
    validates :completed_in, presence: true
  
    COMPLETED_IN = %w[regulation overtime shootout forfeit]
    def self.completed_in_options
      COMPLETED_IN.collect{ |o| [o.humanize, o] }
    end
      
  end
end
