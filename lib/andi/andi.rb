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
    end


  end
end 
