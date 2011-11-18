require 'spec_helper'

describe Score::HockeyEvent do

  it { should be_referenced_in(:home_team).of_type(Score::Team) }
  it { should have_fields(:home_team_name, :home_custom_name) }

  it { should be_referenced_in(:away_team).of_type(Score::Team) }
  it { should have_fields(:away_team_name, :away_custom_name) }
  
  context "when saving" do

    before(:all) do
      @event = Fabricate.build(:hockey_event)
    end

    it "should be valid" do
      @event.valid?.should == true
    end

    it "should update the home team name" do
      @event.save
      @event.home_team_name.should == @event.home_team.name
    end

    it "should update the away team name" do
      @event.save
      @event.away_team_name.should == @event.away_team.name
    end
    
    it "should update the summary to contain the team names" do
      @event.save
      @event.summary.should == "#{@event.away_team_name} at #{@event.home_team_name}"
    end    

  end  
  
end
