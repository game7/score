require 'spec_helper'

describe Score::TeamObserver do

  let (:observer) do
    Score::TeamObserver.instance
  end

  describe "#after_create" do

    let(:season) { Fabricate(:season) }
    let(:division) { Fabricate(:division, :season => season) }
    let(:team) { Fabricate(:team, :division => division)}

    before do
      team.save
      observer.after_create(team)
    end

    it "updates the team_count name for the parent division" do
      division.team_count.should == 1
    end

  end
  
  describe "#after_create" do

    let(:season) { Fabricate(:season) }
    let(:division) { Fabricate(:division, :season => season) }
    let(:team) { Fabricate(:team, :division => division)}

    before do
      team.save
    end

    it "updates the team_count name for the parent division" do
      division.team_count.should == 1
      observer.after_destroy(team)
      division.team_count.should == 0   
    end

  end  
  
end
