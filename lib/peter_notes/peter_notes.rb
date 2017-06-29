require "peter_notes/version"
require 'models/preferences'
require 'models/notes'

def run
  preferences = Preferences.new
  notes = Notes.new(preferences)
  notes.run
end
