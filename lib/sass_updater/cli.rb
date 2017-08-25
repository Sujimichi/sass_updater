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

      opts = options || {}
      opts = opts.dup
      opts[:backup] = false if opts[:display]

      if files.empty?
        extensions = opts[:extensions]
        extensions = extensions.map{|ext| ext.sub(/^\./,"")} #remove . from start of extensions
        f = "{#{extensions.join(",")}}"
        files = Dir.glob("**/*.#{f}")
      end

      files.each do |file|
        puts "\nWorking on #{file}:"
        file_data = File.open(file, "r"){|f| f.readlines}

        puts "file has #{file_data.size} lines"
        processor = Processor.new(file_data)

        if processor.needs_updating?

          if opts[:backup]
            File.open("#{file}.backup", "w"){|f| f.write file_data.join}
            puts "backup written to #{file}.backup"         
          end

          processor.update_sass{|count, line, new_line| print "changes: #{count}"; print "\r"; sleep 0.01}
          puts "\n"

          if opts[:display]
            puts processor.updated
          else
            print "saving #{file}..."
            File.open(file,'w'){|f| f.write processor.updated.join}
          end

          puts "done"               
        else
          puts "no changes needed to file"
        end
      end

    end

  end
end


