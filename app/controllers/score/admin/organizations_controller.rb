module Score
  class Admin::OrganizationsController < ApplicationController
    
    crudify 'score/organization'
    
    def index
      @organizations = Score::Organization.all.asc(:name)
    end
  
  end
end
