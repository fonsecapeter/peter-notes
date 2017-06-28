# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "peter_notes/version"

Gem::Specification.new do |spec|
  spec.name          = "peter-notes"
  spec.version       = PeterNotes::VERSION
  spec.authors       = ["Peter Fonseca"]
  spec.email         = ["peter.nfonseca@gmail.com"]

  spec.summary       = %q{Lightweight notes manager}
  spec.description   = %q{Manage notes with this minimal gem. You can choose your editor and organize your notes however you choose. If you want to track your notes, this gem will stay out of the way. It's a cli tool, don't try to import it in a ruby file.}
  spec.homepage      = "https://github.com/fonsecapeter/peter-notes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["notes"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "ronn", "~> 0.7.3"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "simplecov-console", "~> 0.4.2"
end
