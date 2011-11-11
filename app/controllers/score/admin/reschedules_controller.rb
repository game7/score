module Score
  class Admin::ReschedulesController < ApplicationController
    
    def new
      @reschedule = Score::Reschedule.new
    end
  
    def create
      @reschedule = Score::Reschedule.new(params[:reschedule])
      if @reschedule.save
        flash[:notice] = "Reschedule has been created"
        redirect_to admin_events_path
      else
        render :action => 'new'
      end
    end
  
  end
end
