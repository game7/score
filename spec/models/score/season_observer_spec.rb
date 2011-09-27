require 'spec_helper'

describe Score::SeasonObserver do

  let (:observer) do
    Score::SeasonObserver.instance
  end

  describe "#after_save" do

    let(:season) { Fabricate(:season) }
    let(:team) { Fabricate(:team, :season => season) }

    before do
      new_name = "New Season Name"
      season.name = new_name
      season.valid?
      observer.after_save(season)
    end

    it "updates the season name for child teams" do
      team.season_name.should == season.name
    end

    it "updates the season slug for child teams" do
      team.season_slug.should == season.slug
    end

  end

end

