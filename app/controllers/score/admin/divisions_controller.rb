module Score
  module Admin
    class DivisionsController < ApplicationController
      
      crudify 'score/division'

      before_filter :find_season
      around_filter :check_partial

      def check_partial
        puts "partial: #{params[:partial]}"
        yield
        puts "session: #{session[:partial]}"
      end      
      
      def index
        @divisions = @season.divisions.asc(:name)
        respond_to do |format|
          format.json { render :json => @divisions }
          format.html
        end    
      end
      
      def before_create
        @instance = @division = @season.divisions.build(params[:division])
        super
      end

      private
      
        def find_season()
          @season = @division ? @division.season : Score::Season.find(params[:season_id])
        end

    end
  end
end

