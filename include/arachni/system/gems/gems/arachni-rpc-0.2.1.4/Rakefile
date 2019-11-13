=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC
    web site for more information on licensing and terms of use.

=end

require 'rubygems'
require File.expand_path( File.dirname( __FILE__ ) ) + '/lib/arachni/rpc/version'

begin
    require 'rspec'
    require 'rspec/core/rake_task'

    RSpec::Core::RakeTask.new
rescue
end

task default: [ :build, :spec ]

desc 'Generate docs'
task :docs do
    outdir = "../arachni-rpc-docs"
    sh "rm -rf #{outdir}"
    sh "mkdir -p #{outdir}"

    sh "yardoc -o #{outdir}"

    sh "rm -rf .yardoc"
end

desc 'Clean up'
task :clean do
    sh 'rm *.gem || true'
end

desc 'Build the arachni-rpc gem.'
task build: [ :clean ] do
    sh 'gem build arachni-rpc.gemspec'
end

desc 'Build and install the arachni gem.'
task install: [ :build ] do
    sh "gem install arachni-rpc-#{Arachni::RPC::VERSION}.gem"
end

desc 'Push a new version to Rubygems'
task publish: [ :build ] do
    sh "git tag -a v#{Arachni::RPC::VERSION} -m 'Version #{Arachni::RPC::VERSION}'"
    sh "gem push arachni-rpc-#{Arachni::RPC::VERSION}.gem"
end
task release: [ :publish ]
