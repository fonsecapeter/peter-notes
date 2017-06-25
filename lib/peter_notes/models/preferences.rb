require 'yaml'

def preferences
  home = ENV['HOME']
  defaults = <<-EOM
editor: vim
notes_dir: #{home}/GoogleDrive/Notes
EOM
  prefs_file = "#{home}/.peter-notes.yml"
  if File.exists?(prefs_file)
    prefs = YAML::load_file(prefs_file)
    return(prefs)
  else
    File.write(prefs_file, defaults)
    return preferences
  end
end
