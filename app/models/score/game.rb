module Score
  class Game < Score::Event
    include Mongoid::Document
    
    embeds_one :result, :class_name => 'Score::GameResult'

    referenced_in :left_team, :class_name => 'Score::Team'
    field :left_name, type: String
    field :left_custom_name, type: Boolean
    field :left_score, type: Integer, default: 0
    validates :left_score, numericality: true
    before_validation do |g|
      if t = self.left_team
        self.left_name = t.name unless left_custom_name
        team_ids << t.id
        division_ids << t.division_id unless division_ids.include?(t.division_id)
      else
        self.left_name = '' unless left_custom_name
      end
    end

    referenced_in :right_team, :class_name => 'Score::Team'
    field :right_name, type: String
    field :right_custom_name, type: Boolean
    field :right_score, type: Integer, default: 0
    validates :right_score, numericality: true
    before_validation do |g|
      if t = self.right_team
        self.right_name = t.name unless right_custom_name
        team_ids << t.id
        division_ids << t.division_id unless division_ids.include?(t.division_id)
      else
        self.right = '' unless right_custom_name
      end
    end
    
    before_validation :update_summary

    field :completed_in, type: String
    COMPLETED_IN = %w[regulation overtime shootout forfeit]
    def self.completed_in_options
      COMPLETED_IN.collect{|o| [o.humanize, o] }
    end

    def has_team?(team)
      id = team.class == Score::Team ? team.id : team
      id == left_team_id || id == right_team_id
    end

    def opponent(team)
      throw :team_not_present unless has_team?(team)
      id = team.class == Team ? team.id : team
      id == left_team_id ? right_team : left_team
    end

    def opponent_id(team)
      throw :team_not_present unless has_team?(team)
      id = team.class == Team ? team.id : team
      id == left_team_id ? right_team_id : left_team_id
    end

    def opponent_name(team)
      throw :team_not_present unless has_team?(team)
      id = team.class == Team ? team.id : team
      id == left_team_id ? right_name : left_name
    end
    
    def has_result?
      result != nil
    end
    
    private
    
      def update_summary
        self.summary = "#{self.left_name} vs. #{self.right_name}"
      end

  end
end

