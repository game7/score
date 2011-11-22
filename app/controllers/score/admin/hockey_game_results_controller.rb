module Score
  class Admin::HockeyGameResultsController < ApplicationController

    before_filter :find_game, :only => [:new, :create, :destroy]

    def new
      @result = @game.build_result(@game.result.attributes)
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
