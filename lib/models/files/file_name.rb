class FileName
  attr_reader :path, :dirname, :filename
  def initialize(path)
    @path = path
    @dirname, @filename = File.split(path)
  end

  def extname
    File.extname(@filename)
  end

  def name
    File.basename(@filename, '.*')
  end

  def no_dir?
    return @dirname == '.'
  end
end
