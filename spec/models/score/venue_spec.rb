require 'spec_helper'

describe Score::Venue do

  it { should have_fields(:name, :short_name) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:short_name) }

  context "upon saving" do
    before(:all) do
      @venue = Fabricate.build(:venue)
      @venue.save
    end
    it "should be valid" do
      @venue.valid?.should == true
    end
    it "generates a short name if none provided" do
      @venue.short_name = nil
      @venue.save
      @venue.short_name.should == @venue.name
    end
  end

end

