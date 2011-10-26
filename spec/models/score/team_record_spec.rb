require 'spec_helper'

describe Score::TeamRecord do
  
  it { should have_fields(:gp, :w, :l, :t, :pct) }
  it { should have_fields(:otl, :sol, :pts) }
  it { should have_fields(:scored, :allowed, :margin) }
  it { should have_fields(:last, :run, :stk) }
  
  it { should be_embedded_in(:team).of_type(Score::Team) }  
  it { should embed_many(:results).of_type(Score::TeamGameResult) }
  
  pending "add some examples for reset!"
  
  pending "add some examples for posting result from game"
  
  pending "add some examples for removing a result for a game"
  
  pending "add some examples for checking existence of a previously-posted result"
    
end
