module Score
  class Admin::HockeyGameResultsController < ApplicationController

    before_filter :find_game, :only => [:new, :create, :destroy]

    def new
      atts = @game.result.attributes if @game.has_result?
      @result = @game.build_result(atts)
    end

    def create
      @result = @game.build_result(params[:hockey_game_result])
      flash[:notice] = "New Result has been created" if @game.save
    end

    def destroy
      @game.result.delete
      flash[:notice] = "Result has been deleted"
    end

    private

      def find_game
        @game = Score::HockeyGame.find(params[:hockey_game_id])
      end
  
  end
end
