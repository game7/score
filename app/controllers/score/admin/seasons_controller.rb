module Score
  module Admin
    class SeasonsController < ApplicationController
      
      crudify "score/season"

      def index
        @seasons = Score::Season.all.desc(:starts_on)
      end

    end
  end
end

