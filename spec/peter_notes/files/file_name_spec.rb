require 'spec_helper'
require 'models/files/file_name'

RSpec.describe FileName do
  let (:dirname) { '/dir/whatever' }
  let (:extname) { '.rb' }
  let (:name) { 'my_file' }
  let (:filename) { "#{name}#{extname}" }
  let (:path) { "#{dirname}/#{filename}" }
  subject(:note) { Note.new(path) }

  context 'when initializing' do
    it 'sets a path, dirname, and filename' do
      expect(note.path).to eq(path)
      expect(note.dirname).to eq(dirname)
      expect(note.filename).to eq(filename)
    end
  end

  it 'has an extname' do
    expect(note.extname).to eq(extname)
  end

  it 'has a name' do
    expect(note.name).to eq(name)
  end

  it 'knows if it has any dirs' do
    expect(note.no_dir?).to be_falsey
    no_dir_note = Note.new('my_note.txt')
    expect(no_dir_note.no_dir?).to be_truthy
  end
end
