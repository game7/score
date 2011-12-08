module Score
  class StandingsController < ApplicationController
    
    def index
      @teams = Score::Team.all.desc('record.pts')
    end
  
  end
end
