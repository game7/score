$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "score/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "score"
  s.version     = Score::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Score."
  s.description = "TODO: Description of Score."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
