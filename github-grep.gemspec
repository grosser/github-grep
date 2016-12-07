name = "github-grep"

Gem::Specification.new name, '0.0.0' do |s|
  s.summary = "Makes github search grep and pipeable"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files bin MIT-LICENSE.txt README.md`.split("\n")
  s.license = "MIT"
  s.required_ruby_version = '>= 2.0.0'
  s.executables = ['github-grep']
  s.add_runtime_dependency "json"
  s.add_development_dependency "rake"
  s.add_development_dependency "bump"
end