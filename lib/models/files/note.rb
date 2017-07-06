require 'fileutils'
require 'models/files/file_name'

class Note < FileName
  def self.touch(path)
    note = new(path)
    FileUtils.makedirs(note.dirname)
    FileUtils.touch(note.path)
    return note
  end

  def initialize(path)
    super
    unless no_dir?
      @dirname = File.expand_path(@dirname)
      @path = File.expand_path(@path)
    end
  end
end
