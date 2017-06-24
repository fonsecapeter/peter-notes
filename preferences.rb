require 'yaml'

def preferences
  home = ENV['HOME']
  defaults = <<~EOM
    editor: vim
    notes_dir: #{home}/GoogleDrive/Notes
  EOM
  defaults.strip!
  prefs_file = "#{home}/.peter-notes.yml"
  begin
    prefs = YAML::load_file(prefs_file)
    return("prefs: #{prefs}")
  rescue
    `touch "#{prefs_file}"`
    `echo "#{defaults}" > #{prefs_file}`
    return preferences
  end
end

if __FILE__ == $0
  puts(preferences)
end
