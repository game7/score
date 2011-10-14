require 'spec_helper'

describe Score::GameResult do

  it { should be_embedded_in(:game).of_type(Score::Game) }
  
  it { should have_fields(:left_score, :right_score, :completed_in) }
  
  it { should validate_presence_of(:left_score)}  
  it { should validate_numericality_of(:left_score) }
  
  it { should validate_presence_of(:right_score)}
  it { should validate_numericality_of(:right_score) }
  
  it { should validate_presence_of(:completed_in)}
  
  it "should provide options for completed_in" do
    options = Score::GameResult.completed_in_options
    options.include?(%w[Regulation regulation]).should == true
    options.include?(%w[Forfeit forfeit]).should == true
    options.include?(%w[Shootout shootout]).should == true
    options.include?(%w[Overtime overtime]).should == true
  end
  
end
