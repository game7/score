module Score
  module Admin
    class SeasonsController < ApplicationController

      before_filter :find_season, :only => [:edit, :update, :destroy]

      def index
        @seasons = Score::Season.all
      end

      def new
        @season = Score::Season.new
      end

      def create
        @season = Score::Season.new(params[:season])
        if @season.save
          flash[:notice] = "New Season has been created"
          redirect_to admin_seasons_path
        else
          render :action => 'new'
        end
      end

      def edit

      end

      def update
        if @season.update_attributes(params[:season])
          flash[:notice] = "Season has been updated"
          redirect_to admin_seasons_path
        else
          render :action => 'edit'
        end
      end

      def destroy
        @season.destroy
        flash[:notice] = "Season has been deleted"
        redirect_to admin_seasons_path
      end

      private

        def find_season
          @season = Score::Season.find(params[:id])
        end

    end
  end
end

