# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "async-rails"
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Chen"]
  s.date = "2015-11-18"
  s.description = "Rails asset pipeline wrapper for async.js"
  s.email = ["jhchen7@gmail.com"]
  s.homepage = "https://github.com/jhchen/async-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "Rails asset pipeline wrapper for async.js"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
