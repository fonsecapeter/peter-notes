require 'spec_helper'
require 'models/files/note'
require 'models/note_book'
require 'peter_notes/version'

RSpec.describe NoteBook do
  let(:prefs) { Preferences.new(Preferences.defaults) }
  subject(:notes) { NoteBook.new(prefs) }

  describe '#initialize' do
    it 'takes in preferences' do
      expect(notes.preferences).to eq(prefs)
    end
  end

  describe '#open_notes' do
    it 'opens notes on run' do
      expect(notes).to receive(:open_notes).with('')
      notes.on_run('')
    end

    context 'without a glob' do
      it 'can open all notes' do
        expect_cds
        expect_open('./')
        expect(notes).to receive(:find).with('').and_return([])
        notes.open_notes('')  # ARGV[0] is set to '' if not given
      end
    end

    context 'with a glob' do
      it 'uses find to open one note' do
        expect_cds
        glob = 'note.txt'
        path = "#{prefs.notes_dir}/#{glob}"
        expect(notes).to receive(:find).with(glob).and_return([path])
        expect_open(path)
        notes.open_notes(glob)
      end
    end
  end

  describe '#find' do
    it 'can find notes' do
      glob = 'note_*'
      paths = "#{prefs.notes_dir}/note_0.txt\n#{prefs.notes_dir}/note_1.txt\n"
      cmd = "find \"#{prefs.notes_dir}\" -name \"#{glob}.*\""
      expect(notes).to receive(:`).with(cmd).and_return(paths)
      expect(notes.find(glob)).to eq(paths.split)
    end

    context 'with dirs' do
      it 'can find notes within dirs fuzzily' do
        dirs = 'secret/nuclear'
        name = 'codes_*'
        glob = Glob.new("#{dirs}/#{name}")
        fuzzy_dirs, _ = glob.fuzzified
        cmd = "find \"#{prefs.notes_dir}\" -name \"#{name}.*\" | grep -e \"#{fuzzy_dirs}\""
        expect(notes).to receive(:`).with(cmd).and_return("#{prefs.notes_dir}/#{glob.path}\n")
        notes.find(glob.path)
      end
    end
  end

  describe '#list' do
    it 'can list notes' do
      path = 'secret_notes'
      expect(notes).to receive(:system).with("tree \"#{prefs.notes_dir}/#{path}\"")
      notes.list(path)
    end


    context 'with a custom lister' do
      it 'uses the lister from preferences' do
        path = 'secret_notes'
        prefs.preferences[:lister] = "ls \"%{path}\""
        expect(notes).to receive(:system).with("ls \"#{prefs.notes_dir}/#{path}\"")
        notes.list(path)
      end
    end
  end

  describe '#search' do
    it 'can search through notes' do
      regex = '^enemies$'
      expect(notes).to receive(:system).with("grep --color=always -r \"#{prefs.notes_dir}\" -e \"#{regex}\"")
      notes.search(regex)
    end

    context 'with a custom searcher' do
      it 'uses the searcher from preferences' do
        target = 'Mr. X'
        prefs.preferences[:searcher] = "ag \"%{regex}\" \"%{notes_dir}\" -Q"
        expect(notes).to receive(:system).with("ag \"#{target}\" \"#{prefs.notes_dir}\" -Q")
        notes.search(target)
      end
    end
  end

  describe '#new' do

    context 'without an extension' do
      it 'will use the preferences extension' do
        name = 'smelloscope_designs'
        expect(Note).to receive(:touch).with("#{prefs.notes_dir}/#{name}.#{prefs.extension}")
        notes.new_note(name)
      end
    end

    context 'with an extension' do
      it 'will use the specified extension' do
        name = 'smelloscope_designs.txt'
        expect(Note).to receive(:touch).with("#{prefs.notes_dir}/#{name}")
        notes.new_note(name)
      end
    end
  end

  describe '#version' do
    it 'has a version number' do
      expect(notes.version).to eq(PeterNotes::VERSION)
    end
  end

  private

  def expect_cds
    expect(Dir).to receive(:chdir).with(prefs.notes_dir)
    expect(Dir).to receive(:chdir).with(Dir.pwd)
  end

  def expect_open(glob)
    expect(notes).to receive(:system).with("#{prefs.editor} #{glob}")
  end
end
