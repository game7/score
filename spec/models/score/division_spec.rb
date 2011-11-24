require 'spec_helper'

describe Score::Division do

  it { should have_fields(:name, :slug) }
  it { should have_fields(:team_count)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  # Association with a Season
  it { should be_referenced_in(:season) }
  it { should have_fields(:season_name, :season_slug) }
  it { should validate_presence_of(:season_id) }

  # Association with teams
  it { should have_many(:teams) }

  context "upon saving" do
    before(:all) do
      @division = Fabricate.build(:division, :season => Fabricate(:season))
      @division.save
    end
    it "should be valid" do
      @division.valid?.should == true
    end
    it "generate a slug" do
      @division.slug.should == @division.name.parameterize
    end
    it "captures the season_name" do
      @division.season_name.should == @division.season.name
    end
    it "captures the season_slug" do
      @division.season_slug.should == @division.season.slug
    end
    it "updates the team_count" do
      @division.team_count.should == 0
      @division.teams << Fabricate.build(:team, :division => @division)
      @division.save
      @division.team_count.should == 1
    end
  end

end

