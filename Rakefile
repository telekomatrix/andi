# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'andi'

task :default => 'spec:run'

PROJ.name = 'andi'
PROJ.authors = 'James Britt / Neurogami'
PROJ.email = 'james@neurogami.com'
PROJ.url = 'http://github.com/neurogami/andi'
PROJ.version = Neurogami::Andi::VERSION
PROJ.rubyforge.name = 'there-is-no-rubyforge-project'
PROJ.dependencies = ['user-choices']
PROJ.exclude = %w(.git pkg )
PROJ.readme_file = 'README.markdown'
PROJ.summary = 'Tool for android development'
PROJ.spec.opts << '--color'


desc "Open GitHub project page"
task :gh do
  warn `firefox http://github.com/Neurogami/andi & `
end

GEMS_DIR =  "/var/www/vhosts/neurogami.com/httpdocs/gems"
desc "Upload gem to ng"
task "upload-gem" do
  Dir[ "./pkg/*"].each do |g|
        next unless g =~ /\.gem$/

        cmd = "scp -v #{g} james_ng@neurogami.com:#{GEMS_DIR}/"
        puts `#{cmd}`

  end
end
# EOF
