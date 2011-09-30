require 'spec_helper'

describe Score::DivisionObserver do

  let (:observer) do
    Score::DivisionObserver.instance
  end

  describe "#after_save with division changes" do

    let(:division) { Fabricate(:division) }
    let(:team) { Fabricate(:team, :division => division) }

    before do
      division.name = "New Division Name"
      division.valid?
      observer.after_save(division)
    end

    it "updates the division name for child teams" do
      team.division_name.should == division.name
    end

    it "updates the division slug for child teams" do
      team.division_slug.should == division.slug
    end

  end

  describe "#after_save with season changes" do

    let(:division) { Fabricate(:division) }
    let(:team) { Fabricate(:team, :division => division) }

    before do
      division.season.name = "New Season Name"
      division.season.save
      division.valid?
      observer.after_save(division)
    end

    it "updates the season id for child teams" do
      team.season_id.should == division.season_id
    end

    it "updates the season name for child teams" do
      team.season_name.should == division.season_name
    end

    it "updates the season slug for child teams" do
      team.season_slug.should == division.season_slug
    end

  end

end

