module Score
  class Admin::HockeyGamesController < ApplicationController

    before_filter :find_game, :only => [:edit, :update]
    before_filter :find_season
    before_filter :load_venues
    before_filter :load_seasons
    before_filter :load_teams
        
    def new
      @game = Score::HockeyGame.new      
    end
  
    def create
      @game = Score::HockeyGame.new(params[:hockey_game])
      if @game.save
        flash[:notice] = "New Hockey Game has been created"
        redirect_to admin_events_path
      else
        render :action => 'new'
      end      
    end
  
    def edit
    end
  
    def update
      if @game.update_attributes(params[:hockey_event])
        flash[:notice] = "Game has been updated"
        redirect_to admin_events_path
      else
        render :action => 'edit'
      end
    end
    
    private
    
      def find_event
        @game = Score::HockeyGame.find(params[:id])
      end
    
      def find_season
        if @game
          @season = @game.season
        elsif params[:season_id]
          @season = Score::Season.find(params[:season_id])
        end
      end
    
      def load_seasons
        @seasons = Score::Season.all.desc(:starts_on)
      end
      
      def load_venues
        @venues = Score::Venue.all.asc(:name)
      end
      
      def load_teams
        @teams = Score::Team.for_season(@season)
      end    
  
  end
end
