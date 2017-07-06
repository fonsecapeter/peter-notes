require 'models/files/file_name'

class Glob < FileName
  def fuzzified
    return fuzzy_dir, fuzzy_name
  end

  private

  def fuzzy_dir
    return nil if no_dir?
    return @dirname.gsub(File::SEPARATOR, '.*')
  end

  def fuzzy_name
    return "#{name}.*" if extname.empty?
    return filename
  end
end
