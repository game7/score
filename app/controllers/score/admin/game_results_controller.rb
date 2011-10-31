module Score
  class Admin::GameResultsController < ApplicationController
    
    before_filter :find_game, :only => [:new, :create, :destroy]
    
    def new
      @game_result = @game.build_result()
    end
  
    def create
      @game_result = @game.build_result(params[:game_result])
      flash[:notice] = "Result has been created" if @game.save
    end
  
    def destroy
      @game.result.delete
      flash[:notice] = "Result has been deleted"
    end
    
    private
    
      def find_game
        @game = Score::Game.find(params[:game_id])
      end
  
  end
end
