module Score
  class Admin::VenuesController < ApplicationController

    before_filter :find_venue, :only => [:edit, :update, :destroy]

    def index
      @venues = Score::Venue.all
    end

    def edit
    end

    def update
      if @venue.update_attributes(params[:venue])
        flash[:notice] = 'Venue has been updated'
        redirect_to admin_venues_path
      else
        render :action => 'edit'
      end
    end

    def new
      @venue = Score::Venue.new
    end

    def create
      @venue = Score::Venue.new(params[:venue])
      if @venue.save()
        flash[:notice] = 'New Venue has been created'
        redirect_to admin_venues_path
      else
        render :action => 'new'
      end
    end

    def destroy
      @venue.destroy
      flash[:notice] = 'Venue has been deleted'
      redirect_to admin_venues_path
    end

    private

      def find_venue
        @venue = Score::Venue.find(params[:id])
      end

  end
end

