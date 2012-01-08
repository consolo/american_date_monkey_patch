Gem::Specification.new do |s|
  s.name = 'american_date_monkey_patch'
  s.version = '1.0.0'
  s.author = 'Andrew Coleman'
  s.email = 'developers@consoloservices.com'
  s.summary = 'American Date Monkey Patch'
  s.description = 'Changes to_date to work with American dates and Active Record'
  s.homepage = 'https://redmine.consoloservices.com'
  s.require_path = '.'
  s.files = [ 'american_date_monkey_patch.rb' ]
  s.add_dependency 'activerecord'
end
