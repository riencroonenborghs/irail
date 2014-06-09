Gem::Specification.new do |s|
  s.name          = 'irail'
  s.version       = '0.0.1'
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.summary       = "iRail API"
  s.description   = "Ruby implementation for the iRail API"
  s.authors       = ["Rien Croonenborghs"]
  s.email         = 'rien@croonenborghs.net'
  s.files         = Dir['lib/**/*.rb'] + Dir['spec/models/**/*.rb']
  s.require_path  = 'lib'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
end