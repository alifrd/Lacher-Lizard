# -*- encoding: utf-8 -*-
# stub: cucumber-rails 1.4.5 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-rails".freeze
  s.version = "1.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aslak Helles\u{f8}y".freeze, "Dennis Bl\u{f6}te".freeze, "Rob Holland".freeze]
  s.date = "2016-09-27"
  s.description = "Cucumber Generator and Runtime for Rails".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.homepage = "http://cukes.info".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "cucumber-rails-1.4.5".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capybara>.freeze, ["< 3", ">= 1.1.2"])
      s.add_runtime_dependency(%q<cucumber>.freeze, ["< 4", ">= 1.3.8"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
      s.add_runtime_dependency(%q<railties>.freeze, ["< 5.1", ">= 3"])
      s.add_runtime_dependency(%q<mime-types>.freeze, ["< 4", ">= 1.16"])
      s.add_development_dependency(%q<ammeter>.freeze, ["< 1.1.3", ">= 0.2.9"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0.5.1"])
      s.add_development_dependency(%q<aruba>.freeze, ["~> 0.8.0"])
      s.add_development_dependency(%q<builder>.freeze, ["< 4", ">= 2.1.2"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.3.5"])
      s.add_development_dependency(%q<selenium-webdriver>.freeze, [">= 2.45.0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0.7.2"])
      s.add_development_dependency(%q<factory_girl>.freeze, [">= 3.2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["< 4", ">= 2.2"])
      s.add_development_dependency(%q<rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdiscount>.freeze, [">= 2.0.7"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 3.4"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0.8.7"])
    else
      s.add_dependency(%q<capybara>.freeze, ["< 3", ">= 1.1.2"])
      s.add_dependency(%q<cucumber>.freeze, ["< 4", ">= 1.3.8"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
      s.add_dependency(%q<railties>.freeze, ["< 5.1", ">= 3"])
      s.add_dependency(%q<mime-types>.freeze, ["< 4", ">= 1.16"])
      s.add_dependency(%q<ammeter>.freeze, ["< 1.1.3", ">= 0.2.9"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0.5.1"])
      s.add_dependency(%q<aruba>.freeze, ["~> 0.8.0"])
      s.add_dependency(%q<builder>.freeze, ["< 4", ">= 2.1.2"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.3.5"])
      s.add_dependency(%q<selenium-webdriver>.freeze, [">= 2.45.0"])
      s.add_dependency(%q<database_cleaner>.freeze, [">= 0.7.2"])
      s.add_dependency(%q<factory_girl>.freeze, [">= 3.2"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_dependency(%q<rspec>.freeze, ["< 4", ">= 2.2"])
      s.add_dependency(%q<rails>.freeze, [">= 0"])
      s.add_dependency(%q<rdiscount>.freeze, [">= 2.0.7"])
      s.add_dependency(%q<rdoc>.freeze, [">= 3.4"])
      s.add_dependency(%q<yard>.freeze, [">= 0.8.7"])
    end
  else
    s.add_dependency(%q<capybara>.freeze, ["< 3", ">= 1.1.2"])
    s.add_dependency(%q<cucumber>.freeze, ["< 4", ">= 1.3.8"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
    s.add_dependency(%q<railties>.freeze, ["< 5.1", ">= 3"])
    s.add_dependency(%q<mime-types>.freeze, ["< 4", ">= 1.16"])
    s.add_dependency(%q<ammeter>.freeze, ["< 1.1.3", ">= 0.2.9"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0.5.1"])
    s.add_dependency(%q<aruba>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<builder>.freeze, ["< 4", ">= 2.1.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3.5"])
    s.add_dependency(%q<selenium-webdriver>.freeze, [">= 2.45.0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0.7.2"])
    s.add_dependency(%q<factory_girl>.freeze, [">= 3.2"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
    s.add_dependency(%q<rspec>.freeze, ["< 4", ">= 2.2"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<rdiscount>.freeze, [">= 2.0.7"])
    s.add_dependency(%q<rdoc>.freeze, [">= 3.4"])
    s.add_dependency(%q<yard>.freeze, [">= 0.8.7"])
  end
end
