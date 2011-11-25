require 'spec_helper'

describe Score::Team do

  it { should have_fields(:name, :short_name, :slug, :show_in_standings) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:short_name) }
  it { should validate_presence_of(:slug) }

  # Association with a Club
  it { should be_referenced_in(:club) }
  
  # belongs to an organization
  it { should be_referenced_in(:organization)}

  # Association with a Division
  it { should be_referenced_in(:division) }
  it { should have_fields(:division_name, :division_slug) }
  it { should validate_presence_of(:division_id) }

  # Association with a Season
  it { should be_referenced_in(:season) }
  it { should have_fields(:season_name, :season_slug) }

  context "upon saving" do
    before(:all) do
      @team = Fabricate.build(:team, :division => Fabricate(:division))
      @team.save
    end

    it "should be valid" do
      @team.valid?.should == true
    end

    it "generates a short name if none provided" do
      @team.short_name = nil
      @team.save
      @team.short_name.should == @team.name
    end

    it "generates a slug" do
      @team.slug.should == @team.name.parameterize
    end
    it "captures the division name" do
      @team.errors.each{|e| puts e.to_s}
      @team.division_name.should == @team.division.name
    end
    it "captures the division_slug" do
      @team.division_slug.should == @team.division.slug
    end
    it "captures the season from its division" do
      @team.season_id.should == @team.division.season_id
    end
    it "captures the season_name from its division" do
      @team.season_name.should == @team.division.season_name
    end
    it "captures the season_slug from its division" do
      @team.season_slug.should == @team.division.season_slug
    end
  end


end

