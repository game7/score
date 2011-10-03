module Score
  class SeasonObserver < Mongoid::Observer

    def after_save(season)
      season.divisions.each do |d|
        d.update_season_info(season)
        d.save
      end
    end

  end
end

