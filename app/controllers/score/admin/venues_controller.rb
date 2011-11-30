module Score
  class Admin::VenuesController < ApplicationController

    crudify 'score/venue'
    
    def index
      @venues = Score::Venue.all
    end

  end
end

