require 'spec_helper'

describe Score::Models::Schedulable do

  it { Score::Event.should have_fields(:starts, :ends, :duration, :end_type) }

  context "when validating" do

    it { Score::Event.should validate_presence_of(:starts) }
    it { Score::Event.should validate_presence_of(:ends) }
    it { Score::Event.should validate_presence_of(:duration) }
    it { Score::Event.should validate_numericality_of(:duration) }
    it { Score::Event.should validate_presence_of(:end_type) }

  end
  
  it "should indicate when event duration is all day" do
    @event = Fabricate.build(:event)
    @event.end_type = "all_day"
    @event.all_day?.should == true
  end
  
  it "should list the end types" do
    types = Score::Event.end_types
    types.include?("date") == "true"
    types.include?("duration") == "true"
    types.include?("all_day") == "true"
  end
  
  it "should list options for the end types" do
    options = Score::Event.end_type_options
    expectations = %w[date duration all_day].collect{ |o| [o.humanize, o] }
    options.should =~ expectations
  end

  # Its difficult to test this module in isolation so we'll use the Event class
  context "when saving" do

    before(:all) do
      @event = Fabricate.build(:event)
    end

    it "should update the starts_on date/time for all day events to 12:00 AM" do
      now = DateTime.now
      @event.starts = now
      @event.end_type = "all_day"
      @event.save
      @event.starts.should == now.change(:hour => 0).utc
    end

    it "should update the ends_on date/time for all day events to the end of day" do
      now = DateTime.now
      @event.starts = now
      @event.end_type = "all_day"
      @event.save
      @event.ends.should == now.end_of_day.utc
    end

    it "should update the duration all day events to difference between start and end" do
      now = DateTime.now
      @event.starts = now
      @event.end_type = "all_day"
      @event.save
      @event.duration.should == (@event.ends - @event.starts).round/60
    end

    it "should update the end_time to equal start_time + duration" do
      @event.end_type = "duration"
      @event.save
      @event.ends.should == @event.starts.advance(:minutes => @event.duration)
    end

  end

end

