require "./lib/github_grep"

name = "github-grep"

Gem::Specification.new name, GithubGrep::VERSION do |s|
  s.summary = "Makes github search grep and pipeable"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files bin lib MIT-LICENSE.txt README.md`.split("\n")
  s.license = "MIT"
  s.executables = ['github-grep']
  s.add_development_dependency "rake"
  s.add_development_dependency "bump"
end
