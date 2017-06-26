require_relative 'console_app'
require_relative 'preferences'

class Notes < ConsoleApp
  def initialize(prefs)
    @editor = prefs['editor'] || DEFAULT_EDITOR
    @notes_dir = prefs['notes_dir'] || DEFAULT_NOTES_DIR
    super
  end

  def find(glob)
    found = `find ./ -name #{glob}`
    return found.split('\n')
  end

  def open_notes(glob=nil)
    cur_dir = Dir.pwd
    Dir.chdir(@notes_dir)
    if glob.nil?
      found = './'
    else
      found = find(glob)[0]
    end
    system("#{@editor} #{found}")
    Dir.chdir(cur_dir)
  end

  def search(regex)
    system("grep --color=always -r #{@notes_dir} -e #{regex}")
  end

  def list(path)
    system("tree #{@notes_dir}/#{path}")
  end

  def run
    glob = ARGV[0]
    self.open_notes(glob)
  end
end
