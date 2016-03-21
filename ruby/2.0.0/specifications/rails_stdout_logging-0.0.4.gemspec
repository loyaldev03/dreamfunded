# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_stdout_logging"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Dollar", "Jonathan Dance", "Richard Schneeman"]
  s.date = "2015-08-20"
  s.description = "Sets Rails to log to stdout"
  s.email = ["david@heroku.com", "jd@heroku.com", "richard@heroku.com"]
  s.homepage = "https://github.com/heroku/rails_stdout_logging"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "Overrides Rails' built in logger to send all logs to stdout"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, ["~> 3"])
    else
      s.add_dependency(%q<test-unit>, ["~> 3"])
    end
  else
    s.add_dependency(%q<test-unit>, ["~> 3"])
  end
end
