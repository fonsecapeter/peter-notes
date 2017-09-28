require 'spec_helper'
require 'models/files/note'

RSpec.describe Note do
  let (:filename) { 'my_note.txt' }
  describe '#initialize' do
    context 'with dirs' do
      it 'expands paths' do
        dirs = '~/.secret_notes'
        path = "#{dirs}/#{filename}"
        expanded_dirs = '/user/home/.secret_notes'
        expanded_path = "#{expanded_dirs}/#{filename}"
        expect(File).to receive(:expand_path).with(path).and_return(expanded_path)
        expect(File).to receive(:expand_path).with(dirs).and_return(expanded_dirs)
        note = Note.new(path)
        expect(note.path).to eq(expanded_path)
        expect(note.dirname).to eq(expanded_dirs)
      end
    end

    context 'without dirs' do
      it 'doesnt expand paths' do
        path = filename
        expect(File).not_to receive(:expand_path)
        note = Note.new(path)
        expect(note.path).to eq(path)
        expect(note.dirname).to eq('.')
      end
    end
  end

  describe '::touch' do
    it 'returns a new note' do
      expect(FileUtils).to receive(:makedirs)
      expect(FileUtils).to receive(:touch)
      note = Note.touch(filename)
      expect(note.filename).to eq(filename)
    end

    it 'touches a new note file' do
      expect(FileUtils).to receive(:makedirs)
      expect(FileUtils).to receive(:touch).with(filename)
      Note.touch(filename)
    end

    it 'makes dirs if needed' do
      dirs = '/.secret_notes/.extra_secret_notes'
      path = "#{dirs}/#{filename}"
      expect(FileUtils).to receive(:makedirs).with(dirs)
      expect(FileUtils).to receive(:touch).with(path)
      Note.touch(path)
    end
  end
end
