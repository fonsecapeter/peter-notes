require_relative "version"
require_relative 'models/preferences'
require_relative 'models/notes'

def run
  preferences = Preferences.new
  notes = Notes.new(preferences)
  notes.run
end

run
