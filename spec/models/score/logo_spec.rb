require 'spec_helper'

describe Score::Logo do

  it { should have_fields(:crop_x, :crop_y, :crop_h, :crop_w) }
  
  it { should be_embedded_in(:logoable) }
  
  context 'when checking for cropping' do
    
    before(:all) do
      @logo = Fabricate.build(:logo)
      @logo.crop_h = @logo.crop_w = 0
    end
    
    it 'should recognize no cropping' do
      @logo.cropping?.should == false
    end
    
    it 'should not recognize height-only cropping' do
      @logo.crop_h = 10
      @logo.cropping?.should == false
    end
    
    it 'should recognize width-only cropping' do
      @logo.crop_h = 10
      @logo.cropping?.should == false
    end
    
    it 'should recognize both height and width cropping' do
      @logo.crop_h = @logo.crop_w = 10
      @logo.cropping?.should == true
    end
    
  end
  
end
