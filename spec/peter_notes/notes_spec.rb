require 'spec_helper'
require 'models/notes'

RSpec.describe Notes do
  before(:each) do
    @prefs = Preferences.new
    @notes = Notes.new(@prefs)
  end

  it 'takes in preferences' do
    expect(@notes.editor).to eq(@prefs.editor)
    expect(@notes.notes_dir).to eq(@prefs.notes_dir)
  end


  it 'can find notes' do
    glob = 'note.txt'
    path = "#{@prefs.notes_dir}/#{glob}\n"
    expect(@notes).to receive(:`).with("find #{@prefs.notes_dir} -name #{glob}").and_return(path)
    expect(@notes.find('note.txt')).to eq([path.strip])
  end

  it 'can open all notes' do
    expect_cds
    expect_open('./')
    @notes.run
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

  private

  def expect_cds
    expect(Dir).to receive(:chdir).with(@prefs.notes_dir)
    expect(Dir).to receive(:chdir).with(Dir.pwd)
  end

  def expect_open(glob)
    expect(@notes).to receive(:system).with("#{@prefs.editor} #{glob}")
  end
end
