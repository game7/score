require 'spec_helper'

describe Score::DivisionObserver do

  let (:observer) do
    Score::DivisionObserver.instance
  end

  describe "#after_save" do

    let(:division) { Fabricate(:division) }
    let(:team) { Fabricate(:team, :division => division) }

    before do
      new_name = "New Division Name"
      division.name = new_name
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

end

