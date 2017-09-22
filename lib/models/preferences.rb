require 'yaml'

class Preferences
  attr_reader :preferences

  @@primary_defaults = {
    editor: 'vim',
    notes_dir: File.expand_path('~/Notes')
  }
  @@aux_defaults = {
    extension: 'txt',
    lister: "tree \"%{path}\"",
    searcher: "grep --color=always -r \"%{notes_dir}\" -e \"%{regex}\""
  }
  @@defaults = @@aux_defaults.merge(@@primary_defaults)
  @@prefs_file = File.expand_path('~/.peter-notes.yml')

  def self.defaults
    @@defaults
  end

  def self.prefs_file
    @@prefs_file
  end

  def self.defaults_yaml
    @@primary_defaults.to_yaml
  end

  def initialize(prefs=nil)
    @preferences = load_preferences(prefs)
  end

  def self.write_yaml_defaults
    File.write(@@prefs_file, self.defaults_yaml)
  end

  def method_missing(attribute)
    return @preferences[attribute] if @preferences.has_key?(attribute)
    super
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

  def load_preferences(prefs)
    if prefs.nil?
      if File.exists?(@@prefs_file)
        prefs = load_yaml_preferences
      else
        prefs = @@defaults
      end
    end
    merged_prefs = @@defaults.merge(prefs)
    merged_prefs[:notes_dir] = File.expand_path(merged_prefs[:notes_dir])
    return merged_prefs
  end
end
