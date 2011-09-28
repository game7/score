require 'spec_helper'

describe Score::Event do

  it { should have_fields(:starts_on, :ends_on, :duration, :all_day, :summary, :description, :venue_name, :venue_short_name) }
  it { should have_field(:division_ids).of_type(Array) }
  it { should have_field(:team_ids).of_type(Array) }

  it { should be_referenced_in(:season).of_type(Score::Season) }

  context "when validating" do

    it { should validate_presence_of(:starts_on) }
    it { should validate_presence_of(:ends_on) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration) }
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

    it "should update the starts_on date/time for all day events to 12:00 AM" do
      now = DateTime.now
      @event.starts_on = DateTime.now.utc
      @event.all_day = true
      @event.save
      @event.starts_on.should == now.change(:hour => 0).utc
    end

    it "should update the ends_on date/time for all day events to 12:00 AM of the next day" do
      now = DateTime.now
      @event.starts_on = DateTime.now
      @event.all_day = true
      @event.save
      @event.ends_on.should == now.change(:hour => 0).change(:day => now.day + 1).utc
    end

    it "should update the duration all day events to 60*24 minutes" do
      now = DateTime.now
      @event.starts_on = DateTime.now
      @event.all_day = true
      @event.save
      @event.duration.should == (60 * 24)
    end

    it "should update the end_time to equal start_time + duration" do
      @event.save
      @event.ends_on.should == @event.starts_on.advance(:minutes => @event.duration)
    end

    it "should update the venue names" do
      @event.save
      @event.venue_name.should == @event.venue.name
      @event.venue_short_name.should == @event.venue.short_name
    end

  end

end

