$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'second_handler/version'
Gem::Specification.new do |s|
  s.name = 'second_handler'
  s.version = SecondHandler::VERSION
  s.date = SecondHandler::DATE
  s.executables << 'second_handler'
  s.summary = ''
  s.description = ''
  s.authors = ['Sheng Jung Wu', 'Calvin Jeng', 'Henry Chang', 'Yi Wei Huang']
  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files spec/*`.split("\n")
  s.homepage    =  'https://github.com/Smartibuy/ideate-and-scrape'
  s.license     =  'MIT'

  # depend gem
  s.add_development_dependency 'minitest'
  s.add_runtime_dependency 'koala'
end
