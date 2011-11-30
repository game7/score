module Score
  module Admin
    class DivisionsController < ApplicationController
      
      crudify 'score/division'

      before_filter :find_season
      
      def index
        @divisions = @season.divisions.asc(:name)
        respond_to do |format|
          format.json { render :json => @divisions }
          format.html
        end    
      end
      
      def before_create
        @instance = @division = @season.divisions.build(params[:division])
        true
      end

      private
      
        def find_season()
          @season = @division ? @division.season : Score::Season.find(params[:season_id])
        end

    end
  end
end

