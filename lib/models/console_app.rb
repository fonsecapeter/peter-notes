require 'optparse'
require 'models/preferences'

class ConsoleApp
  def run
    arg = ARGV[0] || ''
    OptionParser.new do |opts|
      opts.banner = 'Usage: notes [options]'
      opts.separator('')
      opts.separator('Options:')
      opts.separator('    [FILE-GLOB]                      Open the first file that matches FILE-GLOB if supplied')
      opts.on('-s', '--search REGEX', 'Search within notes') do |regex|
        self.search(regex)
        exit(0)
      end
      opts.on('-f', '--find FILE-GLOB', 'Find notes that fuzzily match FILE-GLOB') do |glob|
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
      opts.on('-v', '--version', 'Show version') do
        puts(self.version)
        exit(0)
      end
      opts.separator('')
      opts.separator("Preferences are loaded from #{Preferences.prefs_file} and should look like:")
      opts.separator(Preferences.defaults_yaml)

      opts.separator('')
      opts.separator("Documentation at https://github.com/fonsecapeter/peter-notes or man peter-notes")
    end.parse!
    self.on_run(arg)
  end
end
