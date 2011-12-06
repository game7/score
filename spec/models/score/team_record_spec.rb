require 'spec_helper'

describe Score::TeamRecord do
  
  it { should have_fields(:gp, :w, :l, :t, :pct) }
  it { should have_fields(:otl, :sol, :pts) }
  it { should have_fields(:scored, :allowed, :margin) }
  it { should have_fields(:last, :run, :stk) }
  
  it { should be_embedded_in(:team).of_type(Score::Team) }  
  it { should embed_many(:results).of_type(Score::TeamGameResult) }
  
  describe 'when posting game results' do
    
    def setup_result(home_score, away_score, completed_in = 'regulation')
      @home ||= Fabricate(:team)
      @away ||= Fabricate(:team)
      game = Fabricate.build(:hockey_game, :home_team => @home, :away_team => @away)
      game.build_result(:home_score => home_score, :away_score => away_score, :completed_in => completed_in)
      game.save
      @home.record.post_game(game)
      @away.record.post_game(game)
    end
    
    it "should correctly update the scoring" do
      setup_result(h = rand(5), a = rand(5))
      @home.record.scored.should == h
      @home.record.allowed.should == a
      @home.record.margin.should == (h-a)
      @away.record.scored.should == a
      @away.record.allowed.should == h
      @away.record.margin.should == (a-h)
    end
    
    it "should correctly update the streak for win/loss" do
      n = rand(5) + 1
      n.times { |i| setup_result(2,1) }
      
      @home.record.stk.should == "Won #{n}"
      @away.record.stk.should == "Lost #{n}"
    end
    
    it "should correctly update the streak for ties" do
      n = rand(5) + 1
      n.times { |i| setup_result(3,3) }
      
      @home.record.stk.should == "Tied #{n}"
      @away.record.stk.should == "Tied #{n}"
    end
    
  end
  
  pending "add some examples for reset!"
  
  pending "add some examples for posting result from game"
  
  pending "add some examples for removing a result for a game"
  
  pending "add some examples for checking existence of a previously-posted result"
    
end
