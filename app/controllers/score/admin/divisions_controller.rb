module Score
  module Admin
    class DivisionsController < ApplicationController

      before_filter :find_division, :only => [:edit, :update, :destroy]
      before_filter :find_season, :only => [:index, :new, :create, :edit, :update, :destroy]
      
      def index
        @divisions = @season.divisions.asc(:name)
        respond_to do |format|
          format.json { render :json => @divisions }
          format.html
        end    
      end

      def new
        @division = Score::Division.new
      end

      def create
        @division = @season.divisions.build(params[:division])
        if @division.save
          flash[:notice] = "New Division has been Created"
        end
      end

      def edit

      end

      def update
        if @division.update_attributes(params[:division])
          flash[:notice] = "Division has been Updated"
        end
      end

      def destroy
        @division.destroy
        flash[:notice] = "Division has been deleted"
      end

      private
      
        def find_season()
          @season = @division ? @division.season : Score::Season.find(params[:season_id])
        end

        def find_division()
          @division = Score::Division.find(params[:id])
        end

    end
  end
end

