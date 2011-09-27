module Score
  class SeasonObserver < Mongoid::Observer

    def after_save(season)
      season.teams.each do |s|
        s.update_season_info(season)
        s.save
      end
    end

  end
end

