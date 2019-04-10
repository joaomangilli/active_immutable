Gem::Specification.new do |s|
  s.name = 'active_record_immutable'
  s.version = '0.1.0'
  s.licenses = 'MIT'
  s.summary = 'ActiveRecord::Immutable'
  s.description = 'ActiveRecord::Immutable'
  s.authors = ['João Mangilli', 'Marcelo Alexandre']
  s.email = ['joaoluissilvamangilli@gmail.com', 'marcelobalexandre@gmail.com']
  s.homepage = 'https://github.com/joaomangilli/active_record_immutable'

  s.files = ['lib/active_record/immutable.rb']
  s.add_runtime_dependency 'activerecord', '>= 5.2.3'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'sqlite3', '~> 1.4.0'
end
