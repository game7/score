module Score
  module Models
    module Schedulable
      extend ActiveSupport::Concern
      
      included do
        field :starts_on, type: Time
        validates :starts_on, :presence => true

        before_validation do |e|
          # set hour to 12:00 AM for all day events
          self.starts_on = self.starts_on.change(:hour => 0) if self.all_day
        end

        field :ends_on, type: Time
        validates :ends_on, :presence => true
        before_validation do |e|
          if all_day
            self.ends_on = starts_on.end_of_day
          else
            self.ends_on = starts_on.advance(:minutes => duration)
          end
        end

        field :duration, type: Integer
        validates :duration, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }
        before_validation do |e|
          self.duration = 24 * 60 if all_day
        end

        def is_date?(o)
          (DateTime.parse(o) rescue ArgumentError) != ArgumentError
        end

        field :all_day, type: Boolean        
      end
      
    end
  end
end