require File.expand_path('../lib/foreman_enc_matcher_value_only/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman_enc_matcher_value_only"
  s.version     = ForemanEncMatcherValueOnly::VERSION
  s.date        = Date.today.to_s
  s.authors     = ["Huai Jiang"]
  s.email       = ["huajiang@ebay.com"]
  s.homepage    = "https://github.com/HuaiJiang/foreman_enc_matcher_value_only.git"
  s.summary     = "get matcher value parameters only for enc."
  s.description = "control enc behavior in settings for each environments"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  #s.add_development_dependency "sqlite3"
end
