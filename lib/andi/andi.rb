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
require 'fileutils'
require 'yaml'


ANDI_CONF = File.expand_path(File.dirname(__FILE__) + '/.andi')

PACKAGE_NAME = '#{options_hash[:base_package]}.#{options_hash[:project_name]}'
PROJ_NAME = '#{options_hash[:project_name]}'
MAIN_ACTIVITY =  '#{options_hash[:main_activity]}'

namespace :avd do
  desc 'List AVDs (buggy; calling the shell script via rake is not working correctly)'
  task :list do
    puts  `android avd list`
  end
end



namespace :app do


  desc "Sign the app"
  task :sign do 
    puts "Run \n\tjarsigner -verbose -keystore default.keystore bin/\#{PROJ_NAME}.apk defaultkey"
    sh "jarsigner -verbose -keystore default.keystore bin/\#{PROJ_NAME}.apk defaultkey"
  end

  desc "Make a keystore thing"
  task 'make-key' do
     puts "Run this, with values of your chosing:\n\t keytool -genkey -v -keystore default.keystore -alias defaultkey -keyalg RSA -validity 10000"
  end


  desc "zipalign"
  task :zipalign do
   puts "  zipalign  -f -v  4 bin/\#{PROJ_NAME}.apk   bin/\#{PROJ_NAME}-signed.apk"
  end

  desc "uninstall the app"
  task :uninstall do
    puts ` adb shell pm uninstall -k  \#{PACKAGE_NAME}`
  end

  desc 'Compile debug version'
  task :debug do
    puts `ant debug`
  end

  desc 'Re-compile and re-install  debug version'
  task 'debug-reinstall' => [:debug, :uninstall , :'debug-install'] do
  end


  desc 'Install debug version'
  task 'debug-install' => :uninstall  do
    puts `adb install ./bin/\#{MAIN_ACTIVITY}-debug.apk `
  end


  desc 'Compile release version'
  task :release do
    puts `ant release`
    puts `mv ./bin/\#{MAIN_ACTIVITY}-unsigned.apk   ./bin/\#{PROJ_NAME}.apk `
  end


  desc 'Install release version'
  task 'release-install' do
    puts `adb install ./bin/\#{PROJ_NAME}.apk `
  end

  desc 'Install release version'
  task 'release-reinstall' => [:uninstall, :release, :sign, 'release-install']

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
      puts `emulator -avd \#{andi_prefs[:avd]} -sdcard ../sdcard1.iso &`
    end
  end

  desc "List available AVDs"
  task :list do
    sh %{ android list avd } do |ok, res|
      if ! ok
        puts "Problems !  (status = \#{res.exitstatus})"
      end
    end
  end
end

namespace :res do

  desc 'basic layout XML'
  task :layout do
    File.open( "res/layout/\#{Time.now.to_i.to_s}.xml", 'w') { |f| f.puts layout_xml  }
  end
end

namespace :dev do
  desc 'Verify AndroidManifest.xml'
  task :xmlcheck do
    require 'rexml/document'
    doc = REXML::Document.new(IO.read('AndroidManifest.xml'))
    puts doc.to_s
  end
end


def layout_xml
%|<?xml version="1.0" encoding="utf-8"?>
<!-- http://developer.android.com/guide/topics/ui/declaring-layout.html -->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              android:layout_width="fill_parent" 
              android:layout_height="fill_parent" 
              android:orientation="vertical" >
    <TextView android:id="@+id/text"
              android:layout_width="wrap_content"
              android:layout_height="wrap_content"
              android:text="Hello, I am a TextView" />
    <Button android:id="@+id/button"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Hello, I am a Button" />
</LinearLayout>
  |
end
 ~
    end
  end
end 
