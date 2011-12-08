# desc "Explaining what the task does"
# task :score do
#   # Task goes here
# end

"require score"

namespace :score do
  desc "Recalculate records for all teams"
  task :recalculate_records => :environment do
    puts 'Resetting team records...'
    Score::Team.all.each do |team|
      puts "- Reset #{team.name}"
      team.record.reset!
      team.record.save
    end
    puts 'Posting games...'
    Score::HockeyGame.all.each do |game|
      if game.has_result?
        puts "- Posting #{game.summary}"
        game.home_team.record.post_game(game) and game.home_team.save if game.home_team
        game.away_team.record.post_game(game) and game.away_team.save if game.away_team
      end
    end
  end
end
