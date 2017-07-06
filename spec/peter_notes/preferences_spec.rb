require 'spec_helper'
require 'models/preferences'

RSpec.describe Preferences do

  let (:editor) { 'kilo' }
  let (:notes_dir) {'/home/peter/secret_nuclear_missile_codes'}
  let (:prefs_dict) do {
    editor: editor,
    notes_dir: notes_dir,
    extension: 'md',
  } end

  context 'when initializing' do
    it 'can accept a hash' do
      prefs = Preferences.new(prefs_dict)
      expect(prefs.preferences).to eq(prefs_dict)
    end

    it 'sets values to attributes' do
      prefs = Preferences.new(prefs_dict)
      expect(prefs.editor).to eq(editor)
      expect(prefs.notes_dir).to eq(notes_dir)
    end

    it 'doesnt set attributes that arent there' do
      prefs = Preferences.new
      expect {prefs.banana}.to raise_error(NoMethodError)
    end

    it 'expands paths' do
      tilde_dir = '~/seret_nuclear_missile_codes'
      prefs_dict[:notes_dir] = tilde_dir
      prefs = Preferences.new(prefs_dict)
      expect(prefs.notes_dir).to eq(File.expand_path(tilde_dir))
      expect(prefs.preferences[:notes_dir]).to eq(File.expand_path(tilde_dir))
    end

    it 'merges values with defaults' do
      prefs = Preferences.new({
        editor: editor
      })
      expect(prefs.editor).to eq(editor)
      expect(prefs.notes_dir).to eq(Preferences.defaults[:notes_dir])
    end

    context 'with a yaml file in the right place' do
      it 'loads yaml' do
        expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(true)
        expect(YAML).to receive(:load_file).with(Preferences.prefs_file).and_return(prefs_dict)
        prefs = Preferences.new
        expect(prefs.preferences).to eq(prefs_dict)
      end

      it 'merges yaml with defaults' do
        new_pref = {notes_dir: notes_dir}
        expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(true)
        expect(YAML).to receive(:load_file).with(Preferences.prefs_file).and_return(new_pref)
        prefs = Preferences.new
        expect(prefs.preferences).to eq(Preferences.defaults.merge(new_pref))
      end
    end

    context 'when there is no hash or yaml file' do
      it 'sets defaults' do
        expect(File).to receive(:exists?).with(Preferences.prefs_file).and_return(false)
        prefs = Preferences.new
        expect(prefs.preferences).to eq(Preferences.defaults)
      end
    end
  end

  context 'hypothetically' do
    it 'can write defaults to yaml' do
      expect(File).to receive(:write).with(Preferences.prefs_file, Preferences.defaults_yaml)
      Preferences.write_yaml_defaults
    end
  end
end
