module Score
  module Admin
    class EventsController < ApplicationController
      
      before_filter :find_event, :only => [:edit, :update, :destroy]
      before_filter :get_seasons, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_venues, :only => [:new, :create, :edit, :update]
      before_filter :get_season_links, :only => [:index]      
      
      def index
        @events = Score::Event.all
      end
  
      def new
        @event = Score::Event.new
      end
      
      def create
        @event = Score::Event.new(params[:event])
        if @event.save
          flash[:notice] = 'Event has been updated'
          redirect_to admin_events_path
        else
          render :action => 'new'
        end
      end
  
      def edit
      end
      
      def update    
        if @event.update_attributes(params[:event])
          flash[:notice] = 'New event has been created'
          redirect_to admin_events_path
        else
          render :action => 'edit'
        end
      end
      
      def destroy
        @event.destroy
        flash[:notice] = 'Event has been deleted'
        redirect_to admin_events_path
      end
      
      private
      
        def find_event
          @event = Score::Event.find(params[:id])
        end
        
        def get_season_links
          @season_links = Score::Season.asc(:starts_on).each.collect{ |s| [s.name, admin_teams_path(:season_id => s.id)] }
        end
        
        def get_seasons
          @seasons = Score::Season.all.desc(:starts_on)
        end
        
        def get_venues
          @venues = Score::Venue.all.asc(:name)
        end
  
    end
  end
end
