# frozen_string_literal: true

require_relative 'lib/qwack/version'

Gem::Specification.new do |s|
  s.name = 'qwack'
  s.version = Qwack::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.6.0'
  s.authors = ['Laurent Humez']
  s.description = <<-DESCRIPTION
    Qwack is an extensible, lightweight DLS to dynamically
    verify and mock scalar types.
    It is meant primilarily to handle parsed JSON objects
    eg: from an API or a database field
  DESCRIPTION

  s.email = 'lahumez@gmail.com'
  s.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH)
  s.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  s.homepage = 'https://github.com/godric/qwack'
  s.licenses = ['MIT']
  s.summary = 'Dynamic typing DLS for plain hashes.'

  s.metadata = {
    'homepage_uri' => 'https://github.com/godric/qwack',
    'source_code_uri' => 'https://github.com/godric/qwack',
    'bug_tracker_uri' => 'https://github.com/godric/qwack/issues',
  }

  s.add_development_dependency('bundler', '>= 1.15.0', '< 3.0')
  s.add_development_dependency('rubocop', '>= 1.36.0', '< 2.0')
  s.add_development_dependency('rubocop-rspec', '>= 2.13.0', '< 3.0')
  s.add_development_dependency('rspec', '>= 3.11.0', '< 4.0')
  s.add_development_dependency('pry')
end