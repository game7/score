module Score
  module Admin   
    class TeamsController < ApplicationController
      
      crudify 'score/team'
      
      before_filter :find_season, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_seasons, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_season_links, :only => [:index]
      before_filter :get_divisions, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_organizations, :only => [:new, :create, :edit, :update]
      
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

      def before_render_new
        @team.season_id = params[:season_id] if params[:season_id]
        @team.division_id = params[:division_id] if params[:division_id]
      end
      
      def show
        @players = @team.players.asc(:last)
      end
      
      private
      
        def find_season
          @season = params[:season_id] ? Score::Season.find(params[:season_id]) : Score::Season.most_recent
          @season ||= Score::Season.next
        end
        
        def get_seasons
          @seasons = Score::Season.all.desc(:starts_on)
        end
        
        def get_divisions
          @divisions = @season ? @season.divisions.asc(:name).entries : []
        end
        
        def get_season_links
          @season_links = Score::Season.asc(:starts_on).each.collect{ |s| [s.name, admin_teams_path(:season_id => s.id)] }
        end
        
        def get_organizations
          @organizations = Score::Organization.asc(:name).entries
        end

    end
  end
end
