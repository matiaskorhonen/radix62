require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("radix62.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["radix62.gemspec"] do
  system "gem build radix62.gemspec"
  system "gem install radix62-#{Monit::VERSION}.gem"
end
