require_relative "version"
require_relative 'models/preferences'
require_relative 'models/notes'

def run
  notes = Notes.new(preferences)
  notes.run
end

run