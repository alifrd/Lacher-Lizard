# -*- encoding: utf-8 -*-
# stub: pony 1.11 ruby lib

Gem::Specification.new do |s|
  s.name = "pony".freeze
  s.version = "1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Wiggins".freeze, "Ben Prew".freeze]
  s.date = "2014-09-11"
  s.description = "Send email in one command: Pony.mail(:to => 'someone@example.com', :body => 'hello')".freeze
  s.email = "ben@throwingbones.com".freeze
  s.homepage = "http://github.com/benprew/pony".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--inline-source".freeze, "--charset=UTF-8".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Send email in one command: Pony.mail(:to => 'someone@example.com', :body => 'hello')".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mail>.freeze, [">= 2.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.14"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10"])
    else
      s.add_dependency(%q<mail>.freeze, [">= 2.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.14"])
      s.add_dependency(%q<rake>.freeze, [">= 10"])
    end
  else
    s.add_dependency(%q<mail>.freeze, [">= 2.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.14"])
    s.add_dependency(%q<rake>.freeze, [">= 10"])
  end
end
