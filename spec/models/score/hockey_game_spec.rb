require 'spec_helper'

describe Score::HockeyGame do

  it { should be_referenced_in(:home_team).of_type(Score::Team) }
  it { should have_fields(:home_team_name, :home_custom_name) }
  it { should be_referenced_in(:home_division).of_type(Score::Division) }
  it { should have_fields(:home_division_name) }
  

  it { should be_referenced_in(:away_team).of_type(Score::Team) }
  it { should have_fields(:away_team_name, :away_custom_name) }
  it { should be_referenced_in(:away_division).of_type(Score::Division) }
  it { should have_fields(:away_division_name) }
  
  it { should embed_one(:result).of_type(Score::HockeyGameResult) }
  
  it "should indicate the presence of result" do
    @game = Fabricate.build(:hockey_game)
    @game.has_result?.should == false
    @game.result = Fabricate.build(:hockey_game_result)
    @game.has_result?.should == true
  end
  
  context "when saving" do

    before(:all) do
      @game = Fabricate.build(:hockey_game)
      @game.save
    end

    specify { @game.should be_valid }

    specify { @game.home_team_name.should == @game.home_team.name }
    specify { @game.away_team_name.should == @game.away_team.name }
    specify { @game.home_division_name.should == @game.home_division.name }
    specify { @game.away_division_name.should == @game.away_division.name }
    specify { @game.summary.should == "#{@game.away_team_name} at #{@game.home_team_name}" }
    
    it "should update the home and away scores from the result" do
      @game.result = Fabricate.build(:hockey_game_result)
      @game.save
      @game.home_score.should == @game.result.home_score
      @game.away_score.should == @game.result.away_score
    end

  end  
  
  context "when result is present" do
    
    before(:all) do
      @game = Fabricate.build(:hockey_game)
      @game.result = Fabricate.build(:hockey_game_result)
      @game.save
    end
    
    specify { @game.winning_team_name.should == (@game.home_team_winning? ? @game.home_team_name : @game.away_team_name) }
    specify { @game.losing_team_name.should == (@game.home_team_winning? ? @game.away_team_name : @game.home_team_name) }
    
    it "should update the summary to contain the team names and score" do
      puts @game.status
      @game.summary.should == "#{@game.winning_team_name} #{@game.winning_team_score}, #{@game.losing_team_name} #{@game.losing_team_score}"
    end
    
  end
  
end
