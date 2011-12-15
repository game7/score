module Score
  module Admin   
    class TeamsController < ApplicationController
      before_filter :find_division, :only => [:new, :create]
      before_filter :get_organizations, :only => [:new, :create, :edit, :update]      
      
      crudify 'score/team'
      
      def index
        @teams = Score::Team.for_season(@season)
        @teams = @teams.for_division(params[:division_id]) if params[:division_id]
        @teams = @teams.asc(:division_name) unless params[:division_id]
        @teams = @teams.asc(:name)
        respond_to do |format|
          format.json { render :json => @teams }
          format.html
        end
      end
      
      def show
        @players = @team.players.asc(:last)
      end
      
      private
      
        def before_create
          @team.division = @division
          true
        end
        
        def find_division
          @division = Score::Division.find(params[:division_id])
        end
        
        def get_divisions
          @divisions = @season ? @season.divisions.asc(:name).entries : []
        end
        
        def get_organizations
          @organizations = Score::Organization.asc(:name).entries
        end

    end
  end
end
