require 'spec_helper'

describe Score::Event do

  it { should have_fields(:starts, :duration, :summary, :description, :venue_name, :venue_short_name) }
  it { should have_field(:division_ids).of_type(Array) }
  it { should have_field(:team_ids).of_type(Array) }

  it { should be_referenced_in(:season).of_type(Score::Season) }

  context "when validating" do

    it { Score::Event.should validate_presence_of(:starts) }
    it { Score::Event.should validate_presence_of(:duration) }
    it { Score::Event.should validate_numericality_of(:duration) }    
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:season_id) }

  end

  context "when saving" do

    before(:all) do
      @event = Fabricate.build(:event)
    end

    it "should be valid" do
      @event.valid?.should == true
    end

    it "should update the venue name and short_name" do
      @event.save
      @event.venue_name.should == @event.venue.name
      @event.venue_short_name.should == @event.venue.short_name
    end

    it "should convert division_ids to BSON" do
      id = BSON::ObjectId.new.to_s
      @event.division_ids = []
      @event.division_ids << id
      @event.save
      @event.division_ids[0].class.should == BSON::ObjectId
    end

    it "should contain only unique division_ids" do
      id = BSON::ObjectId.new
      @event.division_ids = []
      @event.division_ids << id
      @event.division_ids << id
      @event.save
      @event.division_ids.length.should == 1
      @event.division_ids.include?(id) == true
    end

  end

end

