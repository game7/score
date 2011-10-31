require 'spec_helper'

describe Score::Game do
  
  it { should embed_one(:result).of_type(Score::GameResult)}

  it { should be_referenced_in(:left_team).of_type(Score::Team) }
  it { should have_fields(:left_name, :left_custom_name, :left_score) }
  it { should validate_numericality_of(:left_score) }

  it { should be_referenced_in(:right_team).of_type(Score::Team) }
  it { should have_fields(:right_name, :right_custom_name, :right_score) }
  it { should validate_numericality_of(:right_score) }
  
  it "should indicate whether a result has been posted" do
    @game = Fabricate.build(:game)
    @game.has_result?.should == false
    @game.result = Fabricate.build(:game_result)
    @game.has_result?.should == true
  end

  context "when saving" do

    before(:all) do
      @game = Fabricate.build(:game)
    end

    it "should be valid" do
      @game.valid?.should == true
    end

    it "should update the left name" do
      @game.save
      @game.left_name.should == @game.left_team.name
    end

    it "should update the right name" do
      @game.save
      @game.right_name.should == @game.right_team.name
    end

    it "should add the left team to the array of team ids" do
      @game.save
      @game.team_ids.index(@game.left_team_id).should_not == nil
    end

    it "should add the division of the left team to the array of division ids" do
      @game.save
      @game.division_ids.index(@game.left_team.division_id).should_not == nil
    end

    it "should add the right team to the array of team ids" do
      @game.save
      @game.team_ids.index(@game.right_team_id).should_not == nil
    end

    it "should add the division of the right team to the array of division ids" do
      @game.save
      @game.division_ids.index(@game.right_team.division_id).should_not == nil
    end
    
    it "should update the summary to contain the team names" do
      @game.save
      @game.summary.should == "#{@game.left_name} vs. #{@game.right_name}"
    end
    
    it "should update the scores when a game_result is present" do
      @game.result = Fabricate.build(:game_result)
      @game.save
      @game.left_score.should == @game.result.left_score
      @game.right_score.should == @game.result.right_score
    end

  end

  context "when checking for the presence of a team" do

    before(:all) do
      @game = Fabricate.build(:game)
    end

    it "should correctly respond when a team is the left team associated with the game" do
      @game.has_team?(@game.left_team).should == true
    end

    it "should correctly response when a team is the right team associated with the game" do
      @game.has_team?(@game.right_team).should == true
    end

    it "should correctly responsed when a team is not associated with the game" do
      @game.has_team?(Fabricate.build(:team)).should == false
    end

  end

  context "when requesting the opponent of a team" do

    before(:all) do
      @game = Fabricate(:game)
    end

    it "should correctly return the opponent from the left" do
      @game.opponent(@game.right_team).id.should == @game.left_team.id
    end

    it "should correctly return the opponent from the right" do
      @game.opponent(@game.left_team).id.should == @game.right_team.id
    end

    it "should correctly return the opponent_id from the left" do
      @game.opponent_id(@game.right_team).should == @game.left_team.id
    end

    it "should correctly return the opponent_id from the right" do
      @game.opponent_id(@game.left_team).should == @game.right_team.id
    end

    it "should correctly return the opponent_name from the left" do
      @game.opponent_name(@game.right_team).should == @game.left_team.name
    end

    it "should correctly return the opponent_name from the right" do
      @game.opponent_name(@game.left_team).should == @game.right_team.name
    end

    it "should throw team_not_present if the team is not associated" do
      lambda{@game.opponent(Fabricate.build(:team))}.should throw_symbol(:team_not_present)
    end
  end

end

