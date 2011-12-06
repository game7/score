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
      @game = Fabricate.build(:hockey_game)
      @game.build_result(:home_score => home_score, :away_score => away_score, :completed_in => completed_in)
      @game.save
      @home = @game.home_team.record
      @away = @game.away_team.record
      @home.post_game(@game)
      @away.post_game(@game)
    end
    
    it "should be able to correctly update the scoring" do
      setup_result(h = 4, a = 2)
      @home.scored.should == h
      @home.allowed.should == a
      @home.margin.should == (h-a)
      @away.scored.should == a
      @away.allowed.should == h
      @away.margin.should == (a-h)
    end
    
  end
  
  pending "add some examples for reset!"
  
  pending "add some examples for posting result from game"
  
  pending "add some examples for removing a result for a game"
  
  pending "add some examples for checking existence of a previously-posted result"
    
end
