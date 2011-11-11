module Score
  module Models
    module Schedulable
      extend ActiveSupport::Concern
      
      END_TYPES = %w[date duration all_day]        
      
      included do
        
        field :starts, type: Time
        field :ends, type: Time
        field :duration, type: Integer
        field :end_type, type: String
                
        validates :starts, :presence => true
        validates :ends, :presence => true
        validates :duration, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }
        validates :end_type, :presence => true

        before_validation :handle_end_type

      end
  
      module ClassMethods
        
        def end_types
          Schedulable::END_TYPES
        end

        def end_type_options
          END_TYPES.collect{ |o| [o.humanize, o] }
        end
        
      end   
      
      module InstanceMethods
        
        def all_day?
          end_type == "all_day"
        end
     
        private
        
          def handle_end_type
            set_end_from_duration if end_type == "duration"
            set_duration_from_end if end_type == "end"
            set_duration_and_end_to_all_day if end_type == "all_day"
          end
          
          def set_end_from_duration
            self.ends = starts.advance(:minutes => duration)
          end
          
          def set_duration_from_end
            self.duration = ( ( self.ends - self.starts ).round / 60 ).round
          end
          
          def set_duration_and_end_to_all_day
            self.ends ||= self.starts
            self.starts = self.starts.beginning_of_day
            self.ends = self.ends.end_of_day
            set_duration_from_end
          end        
        
      end
      
    end
  end
end