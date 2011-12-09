module Score
  module Admin
    class SeasonsController < ApplicationController
      
      crudify "score/season"
      
      before_filter :parse_starts_on, :only => [:create, :update]

      def index
        @seasons = Score::Season.all.desc(:starts_on)
      end
      
      private
      
        def parse_starts_on
          params[:season][:starts_on] = Chronic.parse(params[:season][:starts_on])
        end

    end
  end
end

