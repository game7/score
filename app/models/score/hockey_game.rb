module Score
  class HockeyGame < Score::Event
    include Mongoid::Document
    
    before_validation :set_home_team_name
    before_validation :set_home_division_name
    before_validation :set_away_team_name
    before_validation :set_away_division_name
    before_validation :set_status
    before_validation :set_home_and_away_score_from_result
    before_validation :set_summary

    

    referenced_in :home_division, :class_name => 'Score::Division'
    field :home_division_name, type: String
    referenced_in :home_team, :class_name => 'Score::Team'
    field :home_team_name, type: String
    field :home_custom_name, type: Boolean
    
    field :home_score, type: Integer
    attr_protected :home_score

    referenced_in :away_division, :class_name => 'Score::Division'
    field :away_division_name, type: String
    referenced_in :away_team, :class_name => 'Score::Team'
    field :away_team_name, type: String
    field :away_custom_name, type: Boolean
    
    field :away_score, type: Integer
    attr_protected :away_score
    
    STATUS = %w[pending in-progress completed final]
    field :status, type: String, default: 'pending'
    attr_protected :status
    
    embeds_one :result, :class_name => 'Score::HockeyGameResult', :cascade_callbacks => true
    
    def pending?
      status == "pending"
    end
    
    def has_result?
      result != nil
    end
    
    def has_team?(team)
      is_home_team?(team) || is_away_team?(team)
    end    
    
    def is_home_team?(team)
      team_id_for(team) == home_team_id
    end
    
    def is_away_team?(team)
      team_id_for(team) == away_team_id
    end    
    
    def opponent(team)
      throw :team_not_present unless has_team?(team)
      is_home_team?(team) ? away_team : home_team
    end

    def opponent_id(team)
      throw :team_not_present unless has_team?(team)
      is_home_team?(team) ? away_team_id : home_team_id
    end

    def opponent_name(team)
      throw :team_not_present unless has_team?(team)
      is_home_team?(team) ? away_team_name : home_team_name
    end
    
    def team_score(team)
      throw :team_not_present unless has_team?(team)
      is_home_team?(team) ? home_score : away_score   
    end
    
    def opponent_score(team)
      throw :team_not_present unless has_team?(team)
      is_home_team?(team) ? away_score : home_score      
    end    
    
    def home_team_winning?
      home_score > away_score
    end
    
    def away_team_winning?
      away_score > home_score
    end
    
    def winning_team_name
      home_team_winning? ? home_team_name : away_team_name
    end
    
    def winning_team_score
      home_team_winning? ? home_score : away_score
    end    
    
    def losing_team_name
      home_team_winning? ? away_team_name : home_team_name
    end
    
    def losing_team_score
      home_team_winning? ? away_score : home_score
    end   
    
    private

      def team_id_for(team)
        team.class == Score::Team ? team.id : team
      end
      
      def set_home_team_name
        if t = self.home_team
          self.home_team_name = t.name unless home_custom_name
        else
          self.home_team_name = '' unless home_custom_name
        end        
      end
      
      def set_home_division_name
        if d = self.home_division
          self.home_division_name = d.name
        else
          self.home_division_name = ''
        end
      end
      
      def set_away_team_name
        if t = self.away_team
          self.away_team_name = t.name unless away_custom_name
        else
          self.away_team_name = '' unless away_custom_name
        end        
      end
      
      def set_away_division_name
        if d = self.away_division
          self.away_division_name = d.name
        else
          self.away_division_name = ''
        end
      end   
      
      def set_summary
        self.summary = pending? ? summary_without_scores : summary_with_scores
      end
      
      def summary_without_scores
        "#{self.away_team_name} at #{self.home_team_name}"
      end
      
      def summary_with_scores
        "#{self.winning_team_name} #{self.winning_team_score}, #{self.losing_team_name} #{self.losing_team_score}"
      end
      
      def set_status
        if has_result?
          self.status = result.final? ? "final" : "completed"
        end
      end
      
      def set_home_and_away_score_from_result
        if has_result?
          self.home_score = result.home_score
          self.away_score = result.away_score
        end
      end
  
  end
end
