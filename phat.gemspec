Gem::Specification.new do |s|
  s.name = 'phat'
  s.version = '0.0.2'

  s.summary = 'Format-agnostic templating for API responses'
  s.description = 'Format-agnostic templating for API responses in Rails 3' # TODO

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5")
  s.authors = ['Roland Venesz']
  s.date = '2010-10-28'
  s.files = %w(README.md LICENSE) + Dir['lib/**/*.rb']
  s.require_paths = %w(lib)
end
