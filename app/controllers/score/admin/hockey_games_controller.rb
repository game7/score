require 'chronic'

module Score
  class Admin::HockeyGamesController < ApplicationController

    before_filter :find_game, :only => [:edit, :update]
    before_filter :find_season
    before_filter :load_venues
    before_filter :load_seasons
    before_filter :load_divisions
    before_filter :load_teams
        
    def new
      @game = Score::HockeyGame.new      
    end
  
    def create
      params[:hockey_game][:starts] = Chronic.parse(params[:hockey_game][:starts])
      @game = Score::HockeyGame.new(params[:hockey_game])
      if @game.save
        flash[:notice] = "New Hockey Game has been created"
        redirect_to admin_events_path
      else
        load_teams
        render :action => 'new'
      end      
    end
  
    def edit
    end

    def update
      params[:hockey_game][:starts] = Chronic.parse(params[:hockey_game][:starts])      
      if @game.update_attributes(params[:hockey_game])
        flash[:notice] = "Game has been updated"
        redirect_to admin_events_path
      else
        render :action => 'edit'
      end
    end
    
    private
    
      def find_game
        @game = Score::HockeyGame.find(params[:id])
      end
    
      def find_season
        if @game
          @season = @game.season
        elsif season_id = params[:season_id]
          @season = Score::Season.find(season_id)
        elsif params[:hockey_game] and season_id = params[:hockey_game][:season_id]
          @season = Score::Season.find(season_id)
        end
      end
    
      def load_seasons
        @seasons = Score::Season.all.desc(:starts_on).entries
      end
      
      def load_divisions
        @divisions = Score::Division.for_season(@season).asc(:name).entries
      end
      
      def load_venues
        @venues = Score::Venue.all.asc(:name).entries
      end
      
      def load_teams
        @away_division_teams = @game ? Score::Team.for_division(@game.home_division_id).entries : []
        @home_division_teams = @game ? Score::Team.for_division(@game.away_division_id).entries : []
      end    
  
  end
end
