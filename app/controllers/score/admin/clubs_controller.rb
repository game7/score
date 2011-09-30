module Score
  module Admin
    class ClubsController < ApplicationController

      before_filter :find_club, :only => [:edit, :update, :destroy]

      def new
        @club = Score::Club.new
      end

      def create
        @club = Score::Club.new(params[:club])
        if @club.save
          flash[:notice] = "New Club has been created"
          redirect_to admin_clubs_path
        else
          render :action => 'new'
        end
      end

      def edit

      end

      def update
        if @club.update_attributes(params[:club])
          flash[:notice] = "Club has been updated"
          redirect_to admin_clubs_path
        else
          render :action => 'edit'
        end
      end

      def destroy
        @club.destroy
        flash[:notice] = "Club has been deleted"
        redirect_to admin_clubs_path
      end

      def index
        @clubs = Score::Club.all
      end

      private

        def find_club
          @club = Score::Club.find(params[:id])
        end

    end
  end
end

