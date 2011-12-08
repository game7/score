require 'spec_helper'
require 'mocha'

describe Score::HockeyGameResultObserver do
  
  let (:observer) do
    Score::HockeyGameResultObserver.instance
  end  

  describe "#after_create" do

    it "posts the game to the both the home and away team's records" do
      game_result = mock()
      game_result.expects(:final?).returns(true)
      game_result.expects(:game).returns(game = mock())
      game.expects(:home_team).returns(home_team = mock()).at_least_once
      game.expects(:away_team).returns(away_team = mock()).at_least_once
      home_team.expects(:record).returns(home_record = mock())
      away_team.expects(:record).returns(away_record = mock())
      home_record.expects(:post_game).with(game).once
      away_record.expects(:post_game).with(game).once
      observer.after_create(game_result)
    end

  end
  
end
