module Score
  module Admin
    module EventsHelper 
      def render_actions_for(event)
        render :partial => "score/admin/#{event.class.name.demodulize.underscore.pluralize}/actions", :locals => { :event => event }
      end      
    end
  end
end
