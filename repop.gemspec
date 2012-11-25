$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "repop/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "repop"
  s.version     = "0.0.8"
  s.authors     = ["Andrea Ranaldi"]
  s.email       = ["andrea.ranaldi@gmail.com"]
  s.homepage    = "https://github.com/MdreW/repop"
  s.summary     = "Conditioned replacement text."
  s.description = "Gem for replacing text based on the research keys."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["GNU-AGPL-3.0","COPYRIGHT", "AUTHORS", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.9"

  s.add_development_dependency "sqlite3"
end
