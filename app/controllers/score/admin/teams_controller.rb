module Score
  module Admin   
    class TeamsController < ApplicationController
      
      before_filter :find_season, :only => [:index, :new, :create, :edit, :update]
      before_filter :find_team, :only => [:show, :edit, :update, :destroy]
      before_filter :get_seasons, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_season_links, :only => [:index]
      before_filter :get_divisions, :only => [:index, :new, :create, :edit, :update]      
      
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
      end

      def edit
      end
      
      def update
        if @team.update_attributes(params[:team])
          flash[:notice] = "Team has been updated"
        end
      end

      def new
        @team = Team.new
      end
      
      def create
        @team = Team.new(params[:team])
        if @team.save
          flash[:notice] = "Team has been created"
        end
      end
      
      def destroy
        @team.destroy
        flash[:notice] = "Team has been deleted"
      end
      
      private
      
        def find_season
          @season = params[:season_id] ? Score::Season.find(params[:season_id]) : Score::Season.most_recent
        end
      
        def find_team
          @team = Score::Team.find(params[:id])
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

    end
  end
end
