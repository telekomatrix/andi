module Neurogami
  class Andi

    REQUIRED_VALUES_ERROR_MSGS = {
      :project_name => "Missing project name.",
      :base_package => "Missing base package name.",
      :target =>  "Missing target."
    }


    # Need this?
    def self.help message = nil
      puts message + "\\\n-----------------------------------\\\n" unless message.nil?
      puts %~ Usage:
      andi <projectName> <MainActivity> [path=./]

  The project name must be suitable for a Java package name. 

  Allowed characters are: a-z A-Z 0-9 _ 
  ~
    end

    def self.errors
      @@errors ||= []
    end

    def self.valid_options?  options_hash
      @@errors = []
      REQUIRED_VALUES_ERROR_MSGS.each do |val, msg|
        @@errors << msg unless options_hash[val]
      end

      @@errors.empty? 
    end

    # Useful values: 
    #   :base_package (i.e. com.neurogami )
    #   :main_activity
    #   :target
    #   :output_path
    #   :project_name
    def self.project options_hash

      options_hash[:output_path] = "." if options_hash[:output_path].to_s.empty?
      options_hash[:output_path].sub!( /\/$/, '')

      #options_hash[:main_activity]
      #options_hash[:target]
      # 
      cmd = "android create project --package #{options_hash[:base_package]}.#{options_hash[:project_name]} --activity #{options_hash[:main_activity]}  --target #{options_hash[:target]}  --path #{options_hash[:output_path]}/#{options_hash[:project_name]} "

      puts `#{cmd}`
      File.open( "#{options_hash[:output_path]}/#{options_hash[:project_name]}/Rakefile", 'w'){ |f| f.puts(rakefile options_hash)}
    end



    def self.rakefile options_hash
      %~
namespace :avd do
  desc 'List AVDs'
  task :list do
    warn  `android avd list`
  end
end



namespace :app do

  desc "uninstall the app"
  task :uninstall do
  warn ` adb shell pm uninstall -k  #{options_hash[:base_package]}.#{options_hash[:project_name]}`
  end

  desc 'Compile debug version'
  task :debug do
    warn `ant debug`
  end

  desc 'Compile release version'
  task :release do
    warn `ant release`
  end


  desc 'Install debug version'
  task 'install-debug' do
    warn `adb install ./bin/#{options_hash[:main_activity]}-debug.apk `
  end
  
      
  desc 'Install release version'
  task 'install-release' do
    warn `adb install ./bin/#{options_hash[:main_activity]}-unsigned.apk `
  end


  desc 'Re-compile and re-install  debug version'
    task 'debug-reinstall' => [:debug, :uninstall , :'debug-install'] do
  end


  desc 'Re-compile and re-install release version'
   task 'debug-reinstall' => [:release, :uninstall , :'release-install'] do
  end


def save_prefs options
  File.open(ANDI_CONF, 'w'){ |f| f.puts(options.to_yaml)}
end

def load_prefs
  if File.exist? ANDI_CONF
    YAML.load_file ANDI_CONF
  else
    {}
  end

end


namespace :avd do

  desc "Run emulator with avd"
  task :emu do
    andi_prefs  = load_prefs

    andi_prefs[:avd] = ENV['AVD'] if ENV['AVD'] 
    save_prefs andi_prefs 
    Thread.new do 
      puts `emulator  -avd #{andi_prefs[:avd]} &`
    end
  end

  desc "List available AVDs"
  task :list do
    sh %{ android list avd } do |ok, res|
      if ! ok
        puts "Problems !  (status = #{res.exitstatus})"
      end
    end
  end
end
      
  
end ~
    end
  end
end 
