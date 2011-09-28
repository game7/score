module Score
  module Admin
    class DivisionsController < ApplicationController

      def index
        @divisions = Score::Division.all
      end

      def new
      end

      def create
      end

      def edit
      end

      def update
      end

      def destroy
      end

    end
  end
end

