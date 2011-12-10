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
    
    it "should capture the home and away team divisions into division_ids array" do
      @game.division_ids.include?(@game.home_division_id).should == true
      @game.division_ids.include?(@game.away_division_id).should == true
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
    
    it "should update the home and away team scoresn from the result" do
      @game.home_score.should == @game.result.home_score
      @game.away_score.should == @game.result.away_score
    end
    
    it "should update the summary to contain the team names and score" do
      puts @game.status
      @game.summary.should == "#{@game.winning_team_name} #{@game.winning_team_score}, #{@game.losing_team_name} #{@game.losing_team_score}"
    end
    
  end
  

  context "when requesting the opponent of a team" do

    before(:all) do
      @game = Fabricate(:hockey_game)
    end

    it "should correctly return the opponent for the away team" do
      @game.opponent(@game.away_team).id.should == @game.home_team.id
    end

    it "should correctly return the opponent for the home team" do
      @game.opponent(@game.home_team).id.should == @game.away_team.id
    end

    it "should correctly return the opponent_id from the left" do
      @game.opponent_id(@game.away_team).should == @game.home_team.id
    end

    it "should correctly return the opponent_id from the right" do
      @game.opponent_id(@game.home_team).should == @game.away_team.id
    end

    it "should correctly return the opponent_name from the left" do
      @game.opponent_name(@game.away_team).should == @game.home_team.name
    end

    it "should correctly return the opponent_name from the right" do
      @game.opponent_name(@game.home_team).should == @game.away_team.name
    end

    it "should throw team_not_present if the team is not associated" do
      lambda{@game.opponent(Fabricate.build(:team))}.should throw_symbol(:team_not_present)
    end
    
  end 
  
  context 'when requesting scores for a team' do
    
    before(:all) do
      @game = Fabricate.build(:hockey_game)
      @game.result = Fabricate.build(:hockey_game_result)
      @game.save
    end
    
    it "should correctly return the score for a team" do
      @game.team_score(@game.home_team_id).should == @game.home_score
      @game.team_score(@game.away_team_id).should == @game.away_score
    end
    
    it "should correctly return the score for a team's opponnent" do
      @game.opponent_score(@game.home_team_id).should == @game.away_score
      @game.opponent_score(@game.away_team_id).should == @game.home_score
    end
  
  end
  
end
