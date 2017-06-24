# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "peter_notes/version"

Gem::Specification.new do |spec|
  spec.name          = "peter-notes"
  spec.version       = Peter::Notes::VERSION
  spec.authors       = ["Peter Fonseca"]
  spec.email         = ["peter.nfonseca@gmail.com"]

  spec.summary       = %q{Lightweight notes manager}
  spec.description   = %q{Manage notes with this minimal gem. You can choose your editor and organize your notes however you choose. If you want to track your notes, this gem will stay out of the way.}
  spec.homepage      = "https://github.com/fonsecapeter/peter-notes"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
