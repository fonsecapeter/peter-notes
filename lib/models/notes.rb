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
    glob_path, glob_terminus = File.split(glob)
    glob_path.gsub!(File::SEPARATOR, '.*')
    cmd = "find \"#{@notes_dir}\" -name \"#{glob_terminus}\""
    puts("#{glob} -> #{glob_path}, #{glob_terminus}")
    if glob_path != '.'  # FILE::split breaks out . for bare file names
      cmd += " | grep -e \"#{glob_path}\""
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
    notes_path = File.join(@notes_dir, path)
    system("tree #{notes_path}")
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
