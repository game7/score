module Score
  class HockeyGame < Score::Event
    include Mongoid::Document
    
    before_validation :set_home_team_name
    before_validation :set_away_team_name
    before_validation :set_summary_to_show_team_matchup

    referenced_in :home_team, :class_name => 'Score::Team'
    field :home_team_name, type: String
    field :home_custom_name, type: Boolean

    referenced_in :away_team, :class_name => 'Score::Team'
    field :away_team_name, type: String
    field :away_custom_name, type: Boolean
    
    private
    
      def set_home_team_name
        if t = self.home_team
          self.home_team_name = t.name unless home_custom_name
        else
          self.home_team_name = '' unless home_custom_name
        end        
      end
      
      def set_away_team_name
        if t = self.away_team
          self.away_team_name = t.name unless away_custom_name
        else
          self.away_team_name = '' unless away_custom_name
        end        
      end
      
      def set_summary_to_show_team_matchup
        self.summary = "#{self.away_team_name} at #{self.home_team_name}"
      end
  
  end
end
