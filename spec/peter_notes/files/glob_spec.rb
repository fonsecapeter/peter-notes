require 'spec_helper'
require 'models/files/glob'

RSpec.describe Glob do
  def get_filename(path)
    glob = Glob.new(path)
    return glob.fuzzified[1]
  end

  def get_dirname(path)
    glob = Glob.new(path)
    return glob.fuzzified[0]
  end


  context 'when fuzzifying' do
    it 'splits by dir/filename' do
      dir = 'my_notes'
      name = 'my_note.txt'
      glob = Glob.new(File.join(dir, name))
      expect(glob.fuzzified).to eq([dir, name])
    end

    context 'with an extension' do
      it 'includes the extension' do
        path = 'my_note.txt'
        glob_filename = get_filename(path)
        expect(glob_filename).to eq(path)
      end
    end

    context 'without an extension' do
      it 'globbishly ignores extensions' do
        path = 'my_note'
        glob_filename = get_filename(path)
        expect(glob_filename).to eq(path + '.*')
      end
    end

    context 'without a directory' do
      it 'returns nil for the dirname' do
        path = 'my_note'
        glob_dirname = get_dirname(path)
        expect(glob_dirname).to be_nil
      end
    end

    context 'with multiple dirs' do
      it 'replaces separators with regex match-alls' do
        dirs = 'secret/nuclear'
        name = 'codes.txt'
        path = File.join(dirs, name)
        glob_dirname = get_dirname(path)
        expect(glob_dirname).to eq(dirs.gsub('/', '.*'))
      end
    end
  end
end
