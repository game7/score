module Score
  class Admin::LogosController < ApplicationController
    before_filter :find_logoable
    
    def edit
      @logo = @logoable.logo
    end
    
    def update
      @logo = @logoable.logo
      if @logo.update_attributes(params[:logo])
        
      end
    end
    
    private
    
      def find_logoable
        params.each do |name, value|  
          if name =~ /(.+)_id$/  
            @logoable = "Score::#{$1.classify}".constantize.find(value)  
          end
        end  
      end
      
  end
end
