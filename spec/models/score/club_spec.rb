require 'spec_helper'

describe Score::Club do

  it { should have_fields(:name, :short_name, :slug) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:short_name) }
  it { should validate_presence_of(:slug) }

  context "upon saving" do
    before(:all) do
      @club = Fabricate.build(:club)
      @club.save
    end

    it "should be valid" do
      @club.valid?.should == true
    end

    it "generates a short name if none provided" do
      @club.short_name = nil
      @club.save
      @club.short_name.should == @club.name
    end

    it "generates a slug" do
      @club.slug.should == @club.name.parameterize
    end

  end


end

