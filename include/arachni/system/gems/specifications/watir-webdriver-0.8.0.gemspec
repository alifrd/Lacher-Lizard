# -*- encoding: utf-8 -*-
# stub: watir-webdriver 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "watir-webdriver".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jari Bakken".freeze]
  s.date = "2015-06-26"
  s.description = "WebDriver-backed Watir".freeze
  s.email = ["jari.bakken@gmail.com".freeze]
  s.homepage = "http://github.com/watir/watir-webdriver".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "watir-webdriver".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Watir on WebDriver".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<selenium-webdriver>.freeze, [">= 2.46.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_development_dependency(%q<yard>.freeze, ["> 0.8.2.1"])
      s.add_development_dependency(%q<webidl>.freeze, [">= 0.1.5"])
      s.add_development_dependency(%q<sinatra>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_development_dependency(%q<fuubar>.freeze, [">= 0"])
      s.add_development_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_development_dependency(%q<activesupport>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard-doctest>.freeze, ["= 0.1.4"])
    else
      s.add_dependency(%q<selenium-webdriver>.freeze, [">= 2.46.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_dependency(%q<yard>.freeze, ["> 0.8.2.1"])
      s.add_dependency(%q<webidl>.freeze, [">= 0.1.5"])
      s.add_dependency(%q<sinatra>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_dependency(%q<fuubar>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 3.0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<yard-doctest>.freeze, ["= 0.1.4"])
    end
  else
    s.add_dependency(%q<selenium-webdriver>.freeze, [">= 2.46.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
    s.add_dependency(%q<yard>.freeze, ["> 0.8.2.1"])
    s.add_dependency(%q<webidl>.freeze, [">= 0.1.5"])
    s.add_dependency(%q<sinatra>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
    s.add_dependency(%q<fuubar>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 3.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<yard-doctest>.freeze, ["= 0.1.4"])
  end
end
