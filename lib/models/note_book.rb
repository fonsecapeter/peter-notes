require 'models/files/glob'
require 'models/files/note'

require 'models/console_app'
require 'models/preferences'
require 'peter_notes/version'

class NoteBook < ConsoleApp
  attr_reader :preferences

  def initialize(prefs)
    @preferences = prefs
  end

  def list(path)
    path = path || ''
    notes_path = File.join(@preferences.notes_dir, path)
    system("tree #{notes_path}")
  end

  def search(regex)
    system("grep --color=always -r #{@preferences.notes_dir} -e #{regex}")
  end

  def new_note(path)
    full_path = File.join(@preferences.notes_dir, path)
    full_path += '.' + @preferences.extension if File.extname(full_path).empty?
    Note.touch(full_path)
  end

  def find(glob)
    return [] if glob.nil? || glob.empty?
    cmd = find_commandify(glob)
    found = `#{cmd}`
    return found.nil? ? found : found.split
  end

  def open_notes(glob)
    enter_dir!
    found = find(glob)[0]
    found = './' if found.nil?
    system("#{@preferences.editor} #{found}")
    leave_dir!
  end

  def on_run(glob)
    open_notes(glob)
  end

  def version
    return PeterNotes::VERSION
  end

  private

  def enter_dir!
    @cur_dir = Dir.pwd
    Dir.chdir(@preferences.notes_dir)
  end

  def leave_dir!
    Dir.chdir(@cur_dir)
  end

  def find_commandify(glob)
    glob = Glob.new(glob)
    glob_path, glob_file = glob.fuzzified
    cmd = "find \"#{@preferences.notes_dir}\" -name \"#{glob_file}\""
    cmd += " | grep -e \"#{glob_path}\"" unless glob_path.nil?
    return cmd
  end
end
