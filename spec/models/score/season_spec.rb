require 'spec_helper'

describe Score::Season do

  it { should have_fields(:name, :slug, :starts_on) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:starts_on) }

  context "upon saving" do
    before(:all) do
      @season = Fabricate.build(:season)
      @season.save
    end
    it "should be valid" do
      @season.valid?.should == true
    end
    it "generates a slug" do
      @season.slug.should == @season.name.parameterize
    end
  end

end

