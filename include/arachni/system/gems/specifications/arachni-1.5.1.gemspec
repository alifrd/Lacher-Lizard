# -*- encoding: utf-8 -*-
# stub: arachni 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "arachni".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tasos Laskos".freeze]
  s.date = "2017-03-29"
  s.description = "Arachni is a feature-full, modular, high-performance Ruby framework aimed towards\nhelping penetration testers and administrators evaluate the security of web applications.\n\nIt is smart, it trains itself by monitoring and learning from the web application's\nbehavior during the scan process and is able to perform meta-analysis using a number of\nfactors in order to correctly assess the trustworthiness of results and intelligently\nidentify (or avoid) false-positives.\n\nUnlike other scanners, it takes into account the dynamic nature of web applications,\ncan detect changes caused while travelling through the paths of a web application\u{2019}s\ncyclomatic complexity and is able to adjust itself accordingly. This way, attack/input\nvectors that would otherwise be undetectable by non-humans can be handled seamlessly.\n\nMoreover, due to its integrated browser environment, it can also audit and inspect\nclient-side code, as well as support highly complicated web applications which make\nheavy use of technologies such as JavaScript, HTML5, DOM manipulation and AJAX.\n\nFinally, it is versatile enough to cover a great deal of use cases, ranging from\na simple command line scanner utility, to a global high performance grid of\nscanners, to a Ruby library allowing for scripted audits, to a multi-user\nmulti-scan web collaboration platform.\n".freeze
  s.email = "tasos.laskos@arachni-scanner.com".freeze
  s.executables = ["arachni_rpcd".freeze, "arachni_restore".freeze, "arachni_console".freeze, "arachni_rpc".freeze, "arachni_rpcd_monitor".freeze, "arachni_reproduce".freeze, "arachni_reporter".freeze, "arachni_rest_server".freeze, "arachni_multi".freeze, "arachni_script".freeze, "arachni".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE.md".freeze, "CHANGELOG.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE.md".freeze, "README.md".freeze, "bin/arachni".freeze, "bin/arachni_console".freeze, "bin/arachni_multi".freeze, "bin/arachni_reporter".freeze, "bin/arachni_reproduce".freeze, "bin/arachni_rest_server".freeze, "bin/arachni_restore".freeze, "bin/arachni_rpc".freeze, "bin/arachni_rpcd".freeze, "bin/arachni_rpcd_monitor".freeze, "bin/arachni_script".freeze]
  s.homepage = "https://www.arachni-scanner.com".freeze
  s.licenses = ["Arachni Public Source License v1.0".freeze]
  s.post_install_message = "\nThank you for installing Arachni, here are some resources which should\nhelp you make the best of it:\n\nHomepage           - http://arachni-scanner.com\nBlog               - http://arachni-scanner.com/blog\nDocumentation      - http://arachni-scanner.com/wiki\nSupport            - http://support.arachni-scanner.com\nGitHub page        - http://github.com/Arachni/arachni\nCode Documentation - http://rubydoc.info/github/Arachni/arachni\nLicense            - Arachni Public Source License v1.0\n                        (https://github.com/Arachni/arachni/blob/master/LICENSE.md)\nAuthor             - Tasos \"Zapotek\" Laskos (http://twitter.com/Zap0tek)\nTwitter            - http://twitter.com/ArachniScanner\nCopyright          - 2010-2017 Sarosys LLC (http://www.sarosys.com)\n\nPlease do not hesitate to ask for assistance (via the support portal)\nor report a bug (via GitHub Issues) if you come across any problem.\n\n".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of web applications.".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<awesome_print>.freeze, ["= 1.6.1"])
      s.add_runtime_dependency(%q<rack>.freeze, ["= 1.6.4"])
      s.add_runtime_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["= 1.0.2"])
      s.add_runtime_dependency(%q<concurrent-ruby-ext>.freeze, ["= 1.0.2"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, ["= 1.2.1"])
      s.add_runtime_dependency(%q<http_parser.rb>.freeze, ["= 0.6.0"])
      s.add_runtime_dependency(%q<coderay>.freeze, ["= 1.1.0"])
      s.add_runtime_dependency(%q<childprocess>.freeze, ["= 0.5.3"])
      s.add_runtime_dependency(%q<msgpack>.freeze, ["= 0.7.0"])
      s.add_runtime_dependency(%q<oj>.freeze, ["= 2.15.0"])
      s.add_runtime_dependency(%q<oj_mimic_json>.freeze, ["= 1.0.1"])
      s.add_runtime_dependency(%q<puma>.freeze, ["= 2.14.0"])
      s.add_runtime_dependency(%q<sinatra>.freeze, ["= 1.4.6"])
      s.add_runtime_dependency(%q<sinatra-contrib>.freeze, ["= 1.4.6"])
      s.add_runtime_dependency(%q<arachni-rpc>.freeze, ["~> 0.2.1.4"])
      s.add_runtime_dependency(%q<typhoeus>.freeze, ["= 1.0.2"])
      s.add_runtime_dependency(%q<addressable>.freeze, ["= 2.3.6"])
      s.add_runtime_dependency(%q<pony>.freeze, ["= 1.11"])
      s.add_runtime_dependency(%q<rb-readline>.freeze, ["= 0.5.1"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["= 1.6.8.1"])
      s.add_runtime_dependency(%q<ox>.freeze, ["= 2.4.11"])
      s.add_runtime_dependency(%q<terminal-table>.freeze, ["= 1.4.5"])
      s.add_runtime_dependency(%q<selenium-webdriver>.freeze, ["= 3.0.1"])
      s.add_runtime_dependency(%q<watir-webdriver>.freeze, ["= 0.8.0"])
      s.add_runtime_dependency(%q<kramdown>.freeze, ["= 1.4.1"])
      s.add_runtime_dependency(%q<loofah>.freeze, ["= 2.0.3"])
    else
      s.add_dependency(%q<awesome_print>.freeze, ["= 1.6.1"])
      s.add_dependency(%q<rack>.freeze, ["= 1.6.4"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<concurrent-ruby>.freeze, ["= 1.0.2"])
      s.add_dependency(%q<concurrent-ruby-ext>.freeze, ["= 1.0.2"])
      s.add_dependency(%q<rubyzip>.freeze, ["= 1.2.1"])
      s.add_dependency(%q<http_parser.rb>.freeze, ["= 0.6.0"])
      s.add_dependency(%q<coderay>.freeze, ["= 1.1.0"])
      s.add_dependency(%q<childprocess>.freeze, ["= 0.5.3"])
      s.add_dependency(%q<msgpack>.freeze, ["= 0.7.0"])
      s.add_dependency(%q<oj>.freeze, ["= 2.15.0"])
      s.add_dependency(%q<oj_mimic_json>.freeze, ["= 1.0.1"])
      s.add_dependency(%q<puma>.freeze, ["= 2.14.0"])
      s.add_dependency(%q<sinatra>.freeze, ["= 1.4.6"])
      s.add_dependency(%q<sinatra-contrib>.freeze, ["= 1.4.6"])
      s.add_dependency(%q<arachni-rpc>.freeze, ["~> 0.2.1.4"])
      s.add_dependency(%q<typhoeus>.freeze, ["= 1.0.2"])
      s.add_dependency(%q<addressable>.freeze, ["= 2.3.6"])
      s.add_dependency(%q<pony>.freeze, ["= 1.11"])
      s.add_dependency(%q<rb-readline>.freeze, ["= 0.5.1"])
      s.add_dependency(%q<nokogiri>.freeze, ["= 1.6.8.1"])
      s.add_dependency(%q<ox>.freeze, ["= 2.4.11"])
      s.add_dependency(%q<terminal-table>.freeze, ["= 1.4.5"])
      s.add_dependency(%q<selenium-webdriver>.freeze, ["= 3.0.1"])
      s.add_dependency(%q<watir-webdriver>.freeze, ["= 0.8.0"])
      s.add_dependency(%q<kramdown>.freeze, ["= 1.4.1"])
      s.add_dependency(%q<loofah>.freeze, ["= 2.0.3"])
    end
  else
    s.add_dependency(%q<awesome_print>.freeze, ["= 1.6.1"])
    s.add_dependency(%q<rack>.freeze, ["= 1.6.4"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["= 1.0.2"])
    s.add_dependency(%q<concurrent-ruby-ext>.freeze, ["= 1.0.2"])
    s.add_dependency(%q<rubyzip>.freeze, ["= 1.2.1"])
    s.add_dependency(%q<http_parser.rb>.freeze, ["= 0.6.0"])
    s.add_dependency(%q<coderay>.freeze, ["= 1.1.0"])
    s.add_dependency(%q<childprocess>.freeze, ["= 0.5.3"])
    s.add_dependency(%q<msgpack>.freeze, ["= 0.7.0"])
    s.add_dependency(%q<oj>.freeze, ["= 2.15.0"])
    s.add_dependency(%q<oj_mimic_json>.freeze, ["= 1.0.1"])
    s.add_dependency(%q<puma>.freeze, ["= 2.14.0"])
    s.add_dependency(%q<sinatra>.freeze, ["= 1.4.6"])
    s.add_dependency(%q<sinatra-contrib>.freeze, ["= 1.4.6"])
    s.add_dependency(%q<arachni-rpc>.freeze, ["~> 0.2.1.4"])
    s.add_dependency(%q<typhoeus>.freeze, ["= 1.0.2"])
    s.add_dependency(%q<addressable>.freeze, ["= 2.3.6"])
    s.add_dependency(%q<pony>.freeze, ["= 1.11"])
    s.add_dependency(%q<rb-readline>.freeze, ["= 0.5.1"])
    s.add_dependency(%q<nokogiri>.freeze, ["= 1.6.8.1"])
    s.add_dependency(%q<ox>.freeze, ["= 2.4.11"])
    s.add_dependency(%q<terminal-table>.freeze, ["= 1.4.5"])
    s.add_dependency(%q<selenium-webdriver>.freeze, ["= 3.0.1"])
    s.add_dependency(%q<watir-webdriver>.freeze, ["= 0.8.0"])
    s.add_dependency(%q<kramdown>.freeze, ["= 1.4.1"])
    s.add_dependency(%q<loofah>.freeze, ["= 2.0.3"])
  end
end
