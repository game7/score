require 'spec_helper'
require 'mocha'

describe Score::TeamObserver do

  let (:observer) do
    Score::TeamObserver.instance
  end
  
  describe "#after_create" do

    it "notifies the parent division that team was created" do
      division = mock()
      division.expects(:team_created).once
      division.expects(:save).once
      team = mock()
      team.expects(:division).returns(division)
      observer.after_create(team)
    end

  end  
  
  describe "#after_destroy" do
    it "notifies the parent division that team was destroyed" do
      division = mock()
      division.expects(:team_destroyed).once
      division.expects(:save).once
      team = mock()
      team.expects(:division).returns(division)
      observer.after_destroy(team)
    end
  end
  
end
