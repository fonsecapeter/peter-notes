require "peter_notes/version"
require 'models/preferences'
require 'models/note_book'

def run
  preferences = Preferences.new
  notes = NoteBook.new(preferences)
  notes.run
end
