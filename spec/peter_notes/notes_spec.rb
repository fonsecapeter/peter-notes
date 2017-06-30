require 'spec_helper'
require 'models/notes'
require 'peter_notes/version'

RSpec.describe Notes do
  before(:each) do
    @prefs = Preferences.new
    @notes = Notes.new(@prefs)
  end

  it 'takes in preferences' do
    expect(@notes.preferences).to eq(@prefs)
  end

  it 'opens notes on run' do
    expect(@notes).to receive(:open_notes).with('')
    @notes.on_run('')
  end

  it 'can find notes' do
    glob = 'note_*'
    paths = "#{@prefs.notes_dir}/note_0.txt\n#{@prefs.notes_dir}/note_1.txt\n"
    cmd = "find \"#{@prefs.notes_dir}\" -name \"#{glob}.*\""
    expect(@notes).to receive(:`).with(cmd).and_return(paths)
    expect(@notes.find(glob)).to eq(paths.split)
  end

  it 'can find notes within dirs fuzzily' do
    glob_path = 'secret/nuclear'
    fuzzy_path = glob_path.gsub('/', '.*')
    glob_terminus = 'codes_*'
    glob = "#{glob_path}/#{glob_terminus}"
    cmd = "find \"#{@prefs.notes_dir}\" -name \"#{glob_terminus}.*\" | grep -e \"#{fuzzy_path}\""
    expect(@notes).to receive(:`).with(cmd).and_return("#{@prefs.notes_dir}/#{glob}\n")
    @notes.find(glob)
  end

  it 'wont ignore extensions if prefs.ignore_extensions? == false' do
    prefs = Preferences.new({notes_dir: @prefs.notes_dir, ignore_extension?: false})
    notes = Notes.new(prefs)
    glob = 'note_*.txt'
    cmd = "find \"#{@prefs.notes_dir}\" -name \"#{glob}\""
    expect(notes).to receive(:`).with(cmd)
    notes.find(glob)
  end

  it 'can open all notes' do
    expect_cds
    expect_open('./')
    expect(@notes).to receive(:find).with('').and_return([])
    @notes.open_notes('')  # ARGV[0] is set to '' if not given
  end

  it 'uses find to open one note' do
    expect_cds
    glob = 'note.txt'
    path = "#{@prefs.notes_dir}/#{glob}"
    expect(@notes).to receive(:find).with(glob).and_return([path])
    expect_open(path)
    @notes.open_notes(glob)
  end

  it 'can list notes' do
    path = 'secret_notes'
    expect(@notes).to receive(:system).with("tree #{@prefs.notes_dir}/#{path}")
    @notes.list(path)
  end

  it 'can search through notes' do
    regex = '^enemies$'
    expect(@notes).to receive(:system).with("grep --color=always -r #{@prefs.notes_dir} -e #{regex}")
    @notes.search(regex)
  end

  it 'has a version' do
    expect(@notes.version).to eq(PeterNotes::VERSION)
  end

  private

  def expect_cds
    expect(Dir).to receive(:chdir).with(@prefs.notes_dir)
    expect(Dir).to receive(:chdir).with(Dir.pwd)
  end

  def expect_open(glob)
    expect(@notes).to receive(:system).with("#{@prefs.editor} #{glob}")
  end
end
