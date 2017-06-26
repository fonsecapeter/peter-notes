require 'yaml'


class Preferences
  attr_reader :editor, :notes_dir, :preferences

  def initialize(prefs=nil)
    @preferences = prefs || load_preferences
    @editor = @preferences[:editor]
    @notes_dir = @preferences[:notes_dir]
  end

  private

  def load_yaml_preferences(prefs_file)
    prefs = YAML::load_file(prefs_file)
    return(
      prefs.inject({}) do |processed, (key, val)|
        processed[key.to_sym] = val
        processed
      end
     )
  end

  def write_yaml_defaults(prefs_file, defaults)
    default_yaml = <<-EOM
editor: #{defaults[:editor]}
notes_dir: #{defaults[:notes_dir]}
EOM
    File.write(prefs_file, default_yaml)
  end

  def load_preferences
    home = ENV['HOME']
    defaults = {
      editor: 'vim',
      notes_dir: "#{home}/Notes"
    }
    prefs_file = "#{home}/.peter-notes.yml"
    if File.exists?(prefs_file)
      prefs = load_yaml_preferences(prefs_file)
      return(defaults.merge(prefs))
    else
      write_yaml_defaults(prefs_file, defaults)
      return load_preferences
    end
  end
end
