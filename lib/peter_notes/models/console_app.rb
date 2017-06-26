require 'optparse'

class ConsoleApp
  def run
    OptionParser.new do |opts|
      opts.banner = 'Usage: peter-notes [options]'
      opts.separator('')
      opts.separator('Options:')
      opts.separator('    [FILE-GLOB]                      Open the first file that matches FILE-GLOB if supplied')
      opts.on('-s', '--search REGEX', 'Search within notes') do |regex|
        self.search(regex)
        exit(0)
      end
      opts.on('-f', '--find FILE-GLOB', 'Find notes that match FILE-GLOB') do |glob|
        puts(self.find(glob))
        exit(0)
      end
      opts.on('-l', '--list [PATH]', 'List all notes', '  (list notes under PATH if supplied)') do |path|
        puts(self.list(path))
        exit(0)
      end
      opts.on('-h', '--help', 'Show this message') do
        puts(opts)
        exit(0)
      end
    end.parse!
  end
end
