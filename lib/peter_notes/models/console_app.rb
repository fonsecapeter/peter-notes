require 'optparse'

class ConsoleApp
  def initialize(*args)
    OptionParser.new do |opts|
      opts.banner = 'Usage: peter-notes.rb [options] or <file-glob>'
      opts.separator('')
      opts.separator('Optional arguments:')
      opts.separator('    <file-glob>                      Open the first matching file')
      opts.on('-s', '--search <regex>', 'Search within notes') do |regex|
        self.search(regex)
        exit(0)
      end
      opts.on('-f', '--find <file-glob>', 'Find notes that match <file-glob>') do |glob|
        puts(self.find(glob))
        exit(0)
      end
    end.parse!
  end
end
