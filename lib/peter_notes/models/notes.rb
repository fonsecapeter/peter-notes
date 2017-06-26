require_relative 'console_app'
require_relative 'preferences'

class Notes < ConsoleApp
  def initialize(prefs)
    @editor = prefs.editor
    @notes_dir = prefs.notes_dir
  end

  def search(regex)
    system("grep --color=always -r #{@notes_dir} -e #{regex}")
  end

  def find(glob)
    found = `find #{@notes_dir} -name #{glob}`
    return found.split('\n')
  end

  def open_notes(glob=nil)
    enter_dir
    if glob.nil?
      found = './'
    else
      found = find(glob)[0]
    end
    system("#{@editor} #{found}")
    leave_dir
  end

  def list(path)
    system("tree #{@notes_dir}/#{path}")
  end

  def run
    super
    glob = ARGV[0]
    open_notes(glob)
  end

  private

  def enter_dir
    @cur_dir = Dir.pwd
    Dir.chdir(@notes_dir)
  end

  def leave_dir
    Dir.chdir(@cur_dir)
  end

end
