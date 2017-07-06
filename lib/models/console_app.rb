require 'optparse'
require 'models/preferences'

class ConsoleApp
  def run
    arg = ARGV[0]
    options = OptionParser.new do |opts|
      opts.banner = 'Usage: notes [options]'
      opts.separator('')
      opts.separator('Options:')
      opts.separator('    [FILE-GLOB]                      Open the first file that matches FILE-GLOB if supplied')
      opts.on('-f', '--find FILE-GLOB', 'Find notes that fuzzily match FILE-GLOB') do |glob|
        puts(find(glob))
        exit(0)
      end
      opts.on('-l', '--list [PATH]', 'List all notes', '  (list notes under PATH if supplied)') do |path|
        list(path)
        exit(0)
      end
      opts.on('-n', '--new PATH', 'Create new note at PATH') do |path|
        new_note(path)
        open_notes(path)
        exit(0)
      end
      opts.on('-s', '--search REGEX', 'Search within notes') do |regex|
        search(regex)
        exit(0)
      end
      opts.separator('')
      opts.on('-h', '--help', 'Show this message') do
        puts(opts)
        exit(0)
      end
      opts.on('-v', '--version', 'Show version') do
        puts(version)
        exit(0)
      end
      opts.separator('')
      opts.separator("Preferences are loaded from #{Preferences.prefs_file} and should look like:")
      opts.separator(Preferences.defaults_yaml)

      opts.separator('')
      opts.separator("Documentation at https://github.com/fonsecapeter/peter-notes or man peter-notes")
    end
    begin
      options.parse!
    rescue OptionParser::InvalidOption
      puts(options)
      exit(1)
    end
    on_run(arg)
  end
end
