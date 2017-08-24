require 'thor'
require 'sass_updater'

module SassUpdater
  class CLI < Thor
    desc "test thing"

    def test
      puts SassUpdater.test
    end
  end
end


