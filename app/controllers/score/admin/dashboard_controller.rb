module Score
  class Admin::DashboardController < ApplicationController
    before_filter :find_season, :only => [:index]
    before_filter :get_seasons, :only => [:index]
    before_filter :get_season_links, :only => [:index]
    before_filter :get_divisions, :only => [:index]
    
    def index
      @teams = Score::Team.for_season(@season).asc(:division_name).asc(:name)
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
        @season_links = Score::Season.asc(:starts_on).each.collect{ |s| [s.name, admin_dashboard_path(:season_id => s.id)] }
      end    
  
  end
end
