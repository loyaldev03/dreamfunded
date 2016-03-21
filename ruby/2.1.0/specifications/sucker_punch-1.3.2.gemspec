# -*- encoding: utf-8 -*-
# stub: sucker_punch 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sucker_punch"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brandon Hilkert"]
  s.date = "2014-12-28"
  s.description = "Asynchronous processing library for Ruby"
  s.email = ["brandonhilkert@gmail.com"]
  s.homepage = "https://github.com/brandonhilkert/sucker_punch"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.3"
  s.summary = "Sucker Punch is a Ruby asynchronous processing using Celluloid, heavily influenced by Sidekiq and girl_friday."

  s.installed_by_version = "2.4.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_runtime_dependency(%q<celluloid>, ["~> 0.16.0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<celluloid>, ["~> 0.16.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<celluloid>, ["~> 0.16.0"])
  end
end
