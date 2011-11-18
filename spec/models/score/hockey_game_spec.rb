require 'spec_helper'

describe Score::HockeyGame do

  it { should be_referenced_in(:home_team).of_type(Score::Team) }
  it { should have_fields(:home_team_name, :home_custom_name) }

  it { should be_referenced_in(:away_team).of_type(Score::Team) }
  it { should have_fields(:away_team_name, :away_custom_name) }
  
  context "when saving" do

    before(:all) do
      @game = Fabricate.build(:hockey_game)
    end

    it "should be valid" do
      @game.valid?.should == true
    end

    it "should update the home team name" do
      @game.save
      @game.home_team_name.should == @game.home_team.name
    end

    it "should update the away team name" do
      @game.save
      @game.away_team_name.should == @game.away_team.name
    end
    
    it "should update the summary to contain the team names" do
      @game.save
      @game.summary.should == "#{@game.away_team_name} at #{@game.home_team_name}"
    end    

  end  
  
end
