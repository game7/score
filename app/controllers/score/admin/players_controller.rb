module Score
  class Admin::PlayersController < ApplicationController
    crudify 'score/player'
    
    before_filter :find_team, :only => [ :new, :create ]
    
    private
    
      def before_create
        @instance = @player = @team.players.build(params[:player])
        super
      end
    
      def find_team()
        @team = @division ? @division.season : Score::Team.find(params[:team_id])
      end
          
  end
end
