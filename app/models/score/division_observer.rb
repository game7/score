module Score
  class DivisionObserver < Mongoid::Observer

    def after_save(division)
      division.teams.each do |t|
        t.update_division_info(division)
        t.save
      end
    end

  end
end

