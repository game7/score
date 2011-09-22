require 'spec_helper'

describe Score::Division do

  it { should have_fields(:name, :slug) }

  it { should validate_presence_of(:name) }
  
end
