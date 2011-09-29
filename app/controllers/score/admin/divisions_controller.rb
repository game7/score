module Score
  module Admin
    class DivisionsController < ApplicationController

      before_filter :find_division, :only => [:edit, :update, :destroy]

      def index
        @divisions = Score::Division.all
      end

      def new
        @division = Score::Division.new
      end

      def create
        @division = Score::Division.new(params[:division])
        if @division.save
          flash[:notice] = "New Division has been Created"
          redirect_to admin_divisions_path
        else
          render :action => 'new'
        end
      end

      def edit

      end

      def update
        if @division.update_attributes(params[:division])
          flash[:notice] = "Division has been Updated"
          redirect_to admin_divisions_path
        else
          render :action => 'edit'
        end
      end

      def destroy
        @division.destroy
        flash[:notice] = "Division has been deleted"
        redirect_to admin_divisions_path
      end

      private

        def find_division()
          @division = Score::Division.find(params[:id])
        end

    end
  end
end

