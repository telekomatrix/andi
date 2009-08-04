module Neurogami
  class Andi


    def self.help message = nil
      puts message + "\\\n-----------------------------------\\\n" unless message.nil?
      puts %~ Usage:
      andi <projectName> <MainActivity> [path=./]

  The project name must be suitable for a Java package name. 

  Allowed characters are: a-z A-Z 0-9 _ 
  ~
    end


    def self.project project_name , main_activity , path='.' 

      path = "." if path.empty?
      path.sub!( /\/$/, '')

      cmd = "android create project --package com.neurogami.#{project_name} --activity #{main_activity}  --target 2  --path #{path}/#{project_name} "

      puts `#{cmd}`
    end


  end
end 
