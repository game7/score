require 'spec_helper'

describe Score::Game do

  it { should be_referenced_in(:left_team).of_type(Score::Team) }
  it { should have_fields(:left_name, :left_custom_name, :left_score) }
  it { should validate_numericality_of(:left_score) }

  it { should be_referenced_in(:right_team).of_type(Score::Team) }
  it { should have_fields(:right_name, :right_custom_name, :right_score) }
  it { should validate_numericality_of(:right_score) }

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

end

