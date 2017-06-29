require 'models/console_app'
require 'models/preferences'
require 'peter_notes/version'

class Notes < ConsoleApp
  attr_reader :editor, :notes_dir

  def initialize(prefs)
    @editor = prefs.editor
    @notes_dir = prefs.notes_dir
  end

  def search(regex)
    system("grep --color=always -r #{@notes_dir} -e #{regex}")
  end

  def find(glob)
    parsed = glob.split('/')
    glob_terminus = parsed.pop
    glob_path = parsed.join('/')
    cmd = "find \"#{@notes_dir}\" -name \"#{glob_terminus}\""
    if glob_path != ''
      cmd += " | grep \"#{glob_path}\""
    end
    found = `#{cmd}`
    return found.split
  end

  def open_notes(glob)
    enter_dir
    found = find(glob)[0]
    if found.nil?
      found = './'
    end
    system("#{@editor} #{found}")
    leave_dir
  end

  def list(path)
    system("tree #{@notes_dir}/#{path}")
  end

  def on_run(glob)
    open_notes(glob)
  end

  def version
    return PeterNotes::VERSION
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
