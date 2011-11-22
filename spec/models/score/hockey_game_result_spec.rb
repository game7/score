require 'spec_helper'

describe Score::HockeyGameResult do
  
  it { should be_embedded_in(:game).of_type(Score::HockeyGame) }
  
  it { should have_fields(:away_score, :home_score, :completed_in, :final?) }
  
  it { should validate_presence_of(:away_score)}  
  it { should validate_numericality_of(:away_score) }
  
  it { should validate_presence_of(:home_score)}
  it { should validate_numericality_of(:home_score) }
  
  it { should validate_presence_of(:completed_in)}
  
  it "should provide options for completed_in" do
    options = Score::GameResult.completed_in_options
    options.include?(%w[Regulation regulation]).should == true
    options.include?(%w[Forfeit forfeit]).should == true
    options.include?(%w[Shootout shootout]).should == true
    options.include?(%w[Overtime overtime]).should == true
  end
  
end
