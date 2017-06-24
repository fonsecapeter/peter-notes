require_relative "version"
require_relative 'preferences'

require 'optparse'

module Peter
  module Notes
    OptionParser.new do |opts|
      opts.banner = "Usage: peter-notes.rb [options] <file-glob>"

    end.parse!
  end
end
