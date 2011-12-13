class Score::Logo
  include Mongoid::Document
  
  embedded_in :logoable, polymorphic: true
  
  field :crop_x, :type => Integer, :default => 0
  field :crop_y, :type => Integer, :default => 0
  field :crop_h, :type=> Integer, :default => 0
  field :crop_w, :type => Integer, :default => 0  
  
  def cropping?
    crop_w > 0 && crop_h > 0
  end

  def crop_changed?
    crop_x_changed? || crop_y_changed? || crop_h_changed? || crop_w_changed?
  end
  
    
end
