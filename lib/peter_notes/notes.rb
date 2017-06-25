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

def open_notes(glob=nil)
  cur_dir = Dir.pwd
  notes_dir = preferences['notes_dir']
  editor = preferences['editor']
  Dir.chdir(notes_dir)
  if glob.nil?
    system("#{editor} #{glob}")
  else
    system("#{editor} ./")
  end
  Dir.chdir(cur_dir)
end


begin
  glob = ARGV[0]
  open_notes(glob)
rescue
  open_notes
end
