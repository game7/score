require 'spec_helper'

describe Score::TeamGameResult do
  
  context "when initializing using game and team" do
    
    before(:all) do
      @game = Fabricate.build(:game, :result => Fabricate.build(:game_result, :left_score => 3, :right_score => 1, :completed_in => 'regulation'))
      @team = @game.left_team
      @team_game_result = Score::TeamGameResult.new(:team => @team, :game => @game)
    end
    
    it "should correctly capture the game info" do
      @team_game_result.game_id.should == @game.id
      @team_game_result.played_on.should == @game.starts_on.to_date
      @team_game_result.completed_in.should == @game.completed_in
    end
    
    it "should correctly capture the opponent of the current team" do
      @team_game_result.opponent_id.should == @game.opponent_id(@team)
    end
    
    it "should correctly capture the current team's score as scored" do
      @team_game_result.scored.should == @game.team_score(@team)
    end
    
    it "should correctly capture the opponent's score as allowed" do
      @team_game_result.allowed.should == @game.opponent_score(@team)
    end
    
    
  end
  
  context "when setting decision" do
    
    before(:all) do
      @result = Score::TeamGameResult.new
    end
    
    it "should be a win when score is greater than opponents" do
      @result.scored = 5
      @result.allowed = 2
      @result.set_decision
      @result.decision.should == "win"
    end
    
    it "should be a loss when score is less than opponents" do
      @result.scored = 1
      @result.allowed = 3
      @result.set_decision
      @result.decision.should == "loss" 
    end
    
    it "should be a tie when score is equal to opponents" do
      @result.scored = 5
      @result.allowed = 5
      @result.set_decision
      @result.decision.should == "tie"
    end
    
  end
end
