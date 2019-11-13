require 'rake'
require 'rspec/core/rake_task'
require 'json'
require 'uri'

desc "Run all specs"
RSpec::Core::RakeTask.new(:test)

task :default => :test

######################################################

require 'rake'
require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'fileutils'

Gem::PackageTask.new(eval File.read('pony.gemspec')) do |p|
	p.need_tar = true if RUBY_PLATFORM !~ /mswin/
end

task :install => [ :package ] do
	sh %{sudo gem install pkg/#{name}-#{version}.gem}
end

task :uninstall => [ :clean ] do
	sh %{sudo gem uninstall #{name}}
end

task :authors do
  token = `cat ~/.github_token`.chomp
  authors = `git log |grep Author |cut -f 1 -d'<' |cut -f2 -d':' |sort -u`
  authors.split(/\n/).each do |a|
    print "* #{a} "
    ainfo = JSON.parse `curl -u #{token}:x-oauth-basic --silent https://api.github.com/search/users?q=#{URI.encode a}`
    puts ainfo unless ainfo['total_count']
    (puts; next) unless ainfo && ainfo['total_count'] > 0
    puts "[@#{ainfo['items'][0]['login']}](#{ainfo['items'][0]['html_url']})"
  end
end

CLEAN.include [ 'pkg', '*.gem', '.config' ]
