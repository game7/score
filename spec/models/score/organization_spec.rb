require 'spec_helper'

describe Score::Organization do

  it { should have_fields(:name, :slug) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  context "upon saving" do
    before(:all) do
      @organization = Fabricate.build(:organization)
      @organization.save
    end

    it "should be valid" do
      @organization.valid?.should == true
    end

    it "generates a slug" do
      @organization.slug.should == @organization.name.parameterize
    end

  end
  
end
