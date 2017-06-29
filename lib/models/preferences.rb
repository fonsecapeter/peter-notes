require 'yaml'

class Preferences
  attr_reader :editor, :notes_dir, :preferences

  @@home_dir = ENV['HOME']
  @@defaults = {
    editor: 'vim',
    notes_dir: "#{@@home_dir}/Notes"
  }
  @@prefs_file = "#{@@home_dir}/.peter-notes.yml"

  def self.defaults
    @@defaults
  end

  def self.prefs_file
    @@prefs_file
  end

  def self.defaults_yaml
    @@defaults.to_yaml
  end

  def initialize(prefs=nil)
    @preferences = prefs || load_preferences
    @preferences[:notes_dir] = File.expand_path(@preferences[:notes_dir])
    @editor = @preferences[:editor]
    @notes_dir = @preferences[:notes_dir]
  end

  def self.write_yaml_defaults
    File.write(@@prefs_file, self.defaults_yaml)
  end

  private

  def load_yaml_preferences
    prefs = YAML::load_file(@@prefs_file)
    return(
      prefs.inject({}) do |processed, (key, val)|
        processed[key.to_sym] = val
        processed
      end
     )
  end

  def load_preferences
    if File.exists?(@@prefs_file)
      prefs = load_yaml_preferences
      return(@@defaults.merge(prefs))
    else
      return @@defaults
    end
  end
end
