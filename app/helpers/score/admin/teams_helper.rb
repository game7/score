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
    def logo_edit_link(team)
      img_url = "#{team.logo.image.tiny.url.to_s}?#{Time.now.to_i}"
      edit_url = edit_admin_team_logo_path(team)
      image = image_tag img_url, :alt => team.name if team.has_logo?
      image ||= 'edit'
      link_to image, edit_url, :class => 'logo edit', :title => 'Edit Team Logo', :remote => true
    end
  end
end
