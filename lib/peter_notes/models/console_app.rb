require 'optparse'

class ConsoleApp
  def initialize(*args)
    OptionParser.new do |opts|
      opts.banner = "Usage: peter-notes.rb [options] or <file-glob>"
      opts.on("-s", "--search <regex>", "Search within notes") do |regex|
        @search_regex = regex
      end
    end.parse!
  end
end
