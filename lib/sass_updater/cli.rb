require 'thor'
require 'sass_updater'

module SassUpdater
  class CLI < Thor
    default_task :file
    
       
    desc "info", "show basic overview"
    def info
      puts "SASS UPDATER"
      puts "A simple command line tool to convert old style Sass properties to the current convention"
      puts "ie:"
      puts "':display none' will be converted to 'display: none'"
    end

    desc "file [file] [args]", "does the thing in the place with the stuff"
    method_option :display,    :type => :boolean, :default => false, :desc => "Only show changes, don't update files",      :aliases => "-d"
    method_option :backup,     :type => :boolean, :default => true,  :desc => "Create a backup of the original sass file"
    method_option :extensions, :type => :array,   :default => ['sass', 'css.sass'], :desc => "extensions to look for"
    def file *files
      puts options.inspect
      puts files.inspect
    end

  end
end


