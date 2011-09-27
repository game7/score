require 'spec_helper'

describe Score::Division do

  it { should have_fields(:name, :slug) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  context "upon saving" do
    before(:all) do
      @division = Fabricate.build(:division)
      @division.save
    end
    it "should be valid" do
      @division.valid?.should == true
    end
    it "generate a slug" do
      @division.slug.should == @division.name.parameterize
    end
  end

end

