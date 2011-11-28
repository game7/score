module Score
  class Admin::OrganizationsController < ApplicationController
    
    before_filter :find_organization, :only => [:edit, :update, :destroy]
    
    def index
      @organizations = Score::Organization.all.asc(:name)
    end
    
    def new
      @organization = Score::Organization.new
    end
    
    def create
      @organization = Score::Organization.new(params[:organization])
      if @organization.save
        flash[:notice] = "New Organization has been created"
      end      
    end
    
    def edit
    end
    
    def update
      if @organization.update_attributes(params[:organization])
        flash[:notice] = "Organization has been updated"
      end      
    end
    
    def destroy
      @organization.destroy
      flash[:notice] = "Organization has been deleted"      
    end
    
    private
    
      def find_organization
        @organization = Score::Organization.find(params[:id])
      end
  
  end
end
