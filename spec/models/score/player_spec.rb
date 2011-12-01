require 'spec_helper'

describe Score::Player do
  
  it { should have_fields(:first, :last, :jersey_number) }
  
  it { should validate_presence_of(:first) }
  it { should validate_presence_of(:last) }
  
  # Association to a team
  it { should be_referenced_in(:team) }
end
