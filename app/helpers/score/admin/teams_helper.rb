module Score
  module Admin::TeamsHelper
    def grouped_by_division(teams)
      groups = []
      current_group = { :id => '' }
      teams.each do |team|
        unless current_group[:id] == team.division_id
          current_group = { :id => team.division_id, :name => team.division_name, :teams => [] }
          groups << current_group
        end
        current_group[:teams] << team
      end 
      groups
    end
  end
end
