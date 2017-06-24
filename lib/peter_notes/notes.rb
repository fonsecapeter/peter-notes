require_relative "version"
require_relative 'preferences'

require 'optparse'

module Peter
  module Notes
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
    end.parse!
  end
end
