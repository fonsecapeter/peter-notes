require 'spec_helper'
require 'peter_notes/models/preferences'

RSpec.describe Preferences do
  before(:each) do
    @editor = 'kilo'
    @notes_dir = 'notes_dir'
    @prefs_dict = {
      editor: @editor,
      notes_dir: @notes_dir
    }
  end

  it 'accepts values' do
    prefs = Preferences.new(@prefs_dict)
    expect(prefs.preferences).to be @prefs_dict
  end

  it 'saves values to attributes' do
    prefs = Preferences.new(@prefs_dict)
    expect(prefs.editor).to be @editor
    expect(prefs.notes_dir).to be @notes_dir
  end
end
