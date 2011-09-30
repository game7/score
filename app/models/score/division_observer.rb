module Score
  class DivisionObserver < Mongoid::Observer

    def after_save(division)
      season = division.season
      division.teams.each do |t|
        t.update_division_info(division)
        t.update_season_info(season)
        t.save
      end
    end

  end
end

