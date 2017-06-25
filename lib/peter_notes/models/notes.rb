require_relative 'console_app'

class Notes < ConsoleApp
  def initialize(prefs)
    @notes_dir = prefs['notes_dir']
    @editor = prefs['editor']
    super
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

  def search
    system("grep --color=always -r #{@notes_dir} -e #{@search_regex}")
  end

  def run
    if @search_regex
      self.search
    else
      glob = ARGV[0]
      self.open_notes(glob)
    end
  end
end
