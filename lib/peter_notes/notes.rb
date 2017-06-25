require_relative "version"
require_relative 'preferences'

require 'optparse'


class Notes
  def initialize(prefs)
    @notes_dir = prefs['notes_dir']
    @editor = prefs['editor']
  end

  def find_notes_by_glob(glob)
    found_globs = `find ./ -name #{glob}`
    return found_globs.split('\n')
  end

  def open_notes(glob=nil)
    cur_dir = Dir.pwd
    Dir.chdir(@notes_dir)
    if glob.nil?
      system("#{@editor}")
    else
      found_glob = find_notes_by_glob(glob)[0]
      system("#{@editor} #{found_glob}")
    end
    Dir.chdir(cur_dir)
  end

  def search(regex)
    system("grep --color=always -r #{@notes_dir} -e #{regex}")
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: peter-notes.rb [options] <file-glob>"

  opts.on("-s", "--search <regex>", "Search within notes") do |regex|
    options[:search] = regex
  end
end.parse!

notes = Notes.new(preferences)
if options[:search]
  notes.search(options[:search])
else
  glob = ARGV[0]
  notes.open_notes(glob)
end

