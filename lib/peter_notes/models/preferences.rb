require 'yaml'

home = ENV['HOME']
DEFAULT_EDITOR = 'vim'
DEFAULT_NOTES_DIR = "#{home}/Notes"
PREFS_FILE = "#{home}/.peter-notes.yml"


def preferences
  defaults = <<-EOM
editor: #{DEFAULT_EDITOR}
notes_dir: #{DEFAULT_NOTES_DIR}
EOM
  if File.exists?(PREFS_FILE)
    prefs = YAML::load_file(PREFS_FILE)
    return(prefs)
  else
    File.write(PREFS_FILE, defaults)
    return preferences
  end
end
