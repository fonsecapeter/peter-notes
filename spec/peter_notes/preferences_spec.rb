require 'spec_helper'
require 'models/preferences'

RSpec.describe Preferences do
  before(:each) do
    @editor = 'kilo'
    @notes_dir = '/home/peter/secret_nuclear_missile_codes'
    @prefs_dict = {
      editor: @editor,
      notes_dir: @notes_dir
    }
  end

  it 'accepts values' do
    prefs = Preferences.new(@prefs_dict)
    expect(prefs.preferences).to eq(@prefs_dict)
  end

  it 'sets values to attributes' do
    prefs = Preferences.new(@prefs_dict)
    expect(prefs.editor).to eq(@editor)
    expect(prefs.notes_dir).to eq(@notes_dir)
  end

  it 'loads yaml' do
    expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(true)
    expect(YAML).to receive(:load_file).with(Preferences.prefs_file).and_return(@prefs_dict)
    prefs = Preferences.new
    expect(prefs.preferences).to eq(@prefs_dict)
  end

  it 'merges yaml with defaults' do
    new_pref = {notes_dir: @notes_dir}
    expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(true)
    expect(YAML).to receive(:load_file).with(Preferences.prefs_file).and_return(new_pref)
    prefs = Preferences.new
    expect(prefs.preferences).to eq(Preferences.defaults.merge(new_pref))
  end

  it 'sets defaults if none given or found in yaml' do
    expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(false)
    prefs = Preferences.new
    expect(prefs.preferences).to eq(Preferences.defaults)
  end

  it 'can write defaults to yaml' do
    expect(File).to receive(:write).with(Preferences.prefs_file, Preferences.defaults.to_yaml)
    Preferences.write_yaml_defaults
  end

  it 'expands paths' do
    notes_dir = '~/seret_nuclear_missile_codes'
    @prefs_dict[:notes_dir] = notes_dir
    prefs = Preferences.new(@prefs_dict)
    expect(prefs.notes_dir).to eq(File.expand_path(notes_dir))
    expect(prefs.preferences[:notes_dir]).to eq(File.expand_path(notes_dir))
  end
end
