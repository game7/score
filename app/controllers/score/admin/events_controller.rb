module Score
  module Admin
    class EventsController < ApplicationController
      
      before_filter :find_event, :only => [:edit, :update, :destroy]
      before_filter :find_season, :only => [:index, :new, :create, :edit, :update] 
      before_filter :find_division, :only => [:index]     
      before_filter :get_seasons, :only => [:index, :new, :create, :edit, :update]
      before_filter :get_venues, :only => [:new, :create, :edit, :update]
      before_filter :get_season_links, :only => [:index]
      before_filter :get_division_links, :only => [:index]      
      
      
      def index
        @events = Score::Event.for_season(@season)
        @events = @events.for_division(@division) if @division
        @events = @events.asc(:starts)
      end
  
      def new
        @event = Score::Event.new
        # default values
        @event.season_id = @seasons[0].id if @seasons.count == 1
        @event.venue_id = @venues[0].id if @venues.count == 1        
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
      end
      
      private
      
        def find_event
          @event = Score::Event.find(params[:id])
        end
        
        def find_season
          @season = params[:season_id] ? Score::Season.find(params[:season_id]) : Score::Season.most_recent
          @season ||= Score::Season.next
        end
        
        def find_division
          @division = Score::Division.find(params[:division_id]) if params[:division_id]
        end        
        
        def get_season_links
          @season_links = Score::Season.asc(:starts_on).each.collect{ |s| [s.name, admin_events_path(:season_id => s.id)] }
        end
        
        def get_division_links
          @division_links = []
          @division_links << ['All', admin_events_path(:season_id => @season.id)]
          @division_links.concat @season.divisions.asc(:name).each.collect{ |d| [d.name, admin_events_path(:season_id => @season.id, :division_id => d.id)] }
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
