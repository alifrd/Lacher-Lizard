# -*- encoding: utf-8 -*-
# stub: sinatra-contrib 1.4.6 ruby lib

Gem::Specification.new do |s|
  s.name = "sinatra-contrib".freeze
  s.version = "1.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Konstantin Haase".freeze, "Gabriel Andretta".freeze, "Zachary Scott".freeze, "Trevor Bramble".freeze, "Katrina Owen".freeze, "Ashley Williams".freeze, "Nicolas Sanguinetti".freeze, "Hrvoje \u{160}imi\u{107}".freeze, "Masahiro Fujiwara".freeze, "Rafael Magana".freeze, "Vipul A M".freeze, "Jack Chu".freeze, "ashley williams".freeze, "Ilya Shindyapin".freeze, "Jake Worth".freeze, "Kashyap".freeze, "Sumeet Singh".freeze, "lest".freeze, "Adrian Paca\u{142}a".freeze, "Aish".freeze, "Alexey Chernenkov".freeze, "Andrew Crump".freeze, "Anton Davydov".freeze, "Bo Jeanes".freeze, "David Asabina".freeze, "Eliot Shepard".freeze, "Eric Marden".freeze, "Gray Manley".freeze, "Guillaume Bouteille".freeze, "Jamie Hodge".freeze, "Koichi Sasada".freeze, "Kyle Lacy".freeze, "Lars Vonk".freeze, "Martin Frost".freeze, "Mathieu Allaire".freeze, "Matt Lyon".freeze, "Matthew Conway".freeze, "Meck".freeze, "Michi Huber".freeze, "Nic Benders".freeze, "Patricio Mac Adden".freeze, "Reed Lipman".freeze, "Samy Dindane".freeze, "Sergey Nartimov".freeze, "Thibaut Sacreste".freeze, "Uchio KONDO".freeze, "Will Bailey".freeze, "undr".freeze]
  s.date = "2015-07-02"
  s.description = "Collection of useful Sinatra extensions".freeze
  s.email = ["konstantin.mailinglists@googlemail.com".freeze, "ohhgabriel@gmail.com".freeze, "inbox@trevorbramble.com".freeze, "e@zzak.io".freeze, "zachary@zacharyscott.net".freeze, "katrina.owen@gmail.com".freeze, "ashley@bocoup.com".freeze, "contacto@nicolassanguinetti.info".freeze, "shime.ferovac@gmail.com".freeze, "m-fujiwara@axsh.net".freeze, "raf.magana@gmail.com".freeze, "vipulnsward@gmail.com".freeze, "jack@jackchu.com".freeze, "konstantin.haase@gmail.com".freeze, "ashley666ashley@gmail.com".freeze, "ilya@shindyapin.com".freeze, "jworth@prevailhs.com".freeze, "kashyap.kmbc@gmail.com".freeze, "ortuna@gmail.com".freeze, "tbramble@chef.io".freeze, "just.lest@gmail.com".freeze, "altpacala@gmail.com".freeze, "aisha.fenton@visfleet.com".freeze, "laise@pisem.net".freeze, "andrew.crump@ieee.org".freeze, "antondavydov.o@gmail.com".freeze, "me@bjeanes.com".freeze, "david@supr.nu".freeze, "eshepard@slower.net".freeze, "eric.marden@gmail.com".freeze, "g.manley@tukaiz.com".freeze, "duffman@via.ecp.fr".freeze, "jamiehodge@me.com".freeze, "ko1@atdot.net".freeze, "kylewlacy@me.com".freeze, "lars.vonk@gmail.com".freeze, "blame@kth.se".freeze, "mathieuallaire@gmail.com".freeze, "matt@flowerpowered.com".freeze, "himself@mattonrails.com".freeze, "yesmeck@gmail.com".freeze, "michi.huber@gmail.com".freeze, "nic@newrelic.com".freeze, "patriciomacadden@gmail.com".freeze, "rmlipman@gmail.com".freeze, "samy@dindane.com".freeze, "just.lest@gmail.com".freeze, "thibaut.sacreste@gmail.com".freeze, "udzura@udzura.jp".freeze, "will.bailey@gmail.com".freeze, "undr@yandex.ru".freeze]
  s.homepage = "http://github.com/sinatra/sinatra-contrib".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Collection of useful Sinatra extensions".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>.freeze, ["~> 1.4.0"])
      s.add_runtime_dependency(%q<backports>.freeze, [">= 2.0"])
      s.add_runtime_dependency(%q<tilt>.freeze, ["< 3", ">= 1.3"])
      s.add_runtime_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rack-protection>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.3"])
      s.add_development_dependency(%q<haml>.freeze, [">= 0"])
      s.add_development_dependency(%q<erubis>.freeze, [">= 0"])
      s.add_development_dependency(%q<slim>.freeze, [">= 0"])
      s.add_development_dependency(%q<less>.freeze, [">= 0"])
      s.add_development_dependency(%q<sass>.freeze, [">= 0"])
      s.add_development_dependency(%q<builder>.freeze, [">= 0"])
      s.add_development_dependency(%q<liquid>.freeze, [">= 0"])
      s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_development_dependency(%q<RedCloth>.freeze, [">= 0"])
      s.add_development_dependency(%q<asciidoctor>.freeze, [">= 0"])
      s.add_development_dependency(%q<radius>.freeze, [">= 0"])
      s.add_development_dependency(%q<coffee-script>.freeze, [">= 0"])
      s.add_development_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_development_dependency(%q<creole>.freeze, [">= 0"])
      s.add_development_dependency(%q<wikicloth>.freeze, [">= 0"])
      s.add_development_dependency(%q<markaby>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sinatra>.freeze, ["~> 1.4.0"])
      s.add_dependency(%q<backports>.freeze, [">= 2.0"])
      s.add_dependency(%q<tilt>.freeze, ["< 3", ">= 1.3"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_dependency(%q<rack-protection>.freeze, [">= 0"])
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.3"])
      s.add_dependency(%q<haml>.freeze, [">= 0"])
      s.add_dependency(%q<erubis>.freeze, [">= 0"])
      s.add_dependency(%q<slim>.freeze, [">= 0"])
      s.add_dependency(%q<less>.freeze, [">= 0"])
      s.add_dependency(%q<sass>.freeze, [">= 0"])
      s.add_dependency(%q<builder>.freeze, [">= 0"])
      s.add_dependency(%q<liquid>.freeze, [">= 0"])
      s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_dependency(%q<RedCloth>.freeze, [">= 0"])
      s.add_dependency(%q<asciidoctor>.freeze, [">= 0"])
      s.add_dependency(%q<radius>.freeze, [">= 0"])
      s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<creole>.freeze, [">= 0"])
      s.add_dependency(%q<wikicloth>.freeze, [">= 0"])
      s.add_dependency(%q<markaby>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>.freeze, ["~> 1.4.0"])
    s.add_dependency(%q<backports>.freeze, [">= 2.0"])
    s.add_dependency(%q<tilt>.freeze, ["< 3", ">= 1.3"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rack-protection>.freeze, [">= 0"])
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.3"])
    s.add_dependency(%q<haml>.freeze, [">= 0"])
    s.add_dependency(%q<erubis>.freeze, [">= 0"])
    s.add_dependency(%q<slim>.freeze, [">= 0"])
    s.add_dependency(%q<less>.freeze, [">= 0"])
    s.add_dependency(%q<sass>.freeze, [">= 0"])
    s.add_dependency(%q<builder>.freeze, [">= 0"])
    s.add_dependency(%q<liquid>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    s.add_dependency(%q<RedCloth>.freeze, [">= 0"])
    s.add_dependency(%q<asciidoctor>.freeze, [">= 0"])
    s.add_dependency(%q<radius>.freeze, [">= 0"])
    s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<creole>.freeze, [">= 0"])
    s.add_dependency(%q<wikicloth>.freeze, [">= 0"])
    s.add_dependency(%q<markaby>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
