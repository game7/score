module Score
  class Change
    include Mongoid::Document
    
    embedded_in :changeable, polymorphic: true
    
  end
end
