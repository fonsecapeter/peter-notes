# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peter_notes/version'

Gem::Specification.new do |spec|
  spec.name          = 'peter-notes'
  spec.version       = PeterNotes::VERSION
  spec.authors       = ['Peter Fonseca']
  spec.email         = ['peter.nfonseca@gmail.com']

  spec.summary       = %q{Lightweight notes manager}
  spec.description   = %q{Manage your notes from the console.

If you're like me, you spend most of your computing time in a terminal, you have a text-editor set up just to your liking, and you wish you could use it for everything. Naturally, when it comes time to ditch your paper note-pad, you refuse to to use the more popular gui-driven apps and want to find a way to use your editor instead.

But when you start looking for a terminal-based notes framework (or plugin for your editor) you're blinded by crazy features and unwilling to learn a new tool. You've also already started keeping your notes in some text files and don't want to have to start over.

Anyway, I went through the same thing and made this this lightweight tool (originally from some aliases in my bashrc) to do what I wanted it to do, which isn't a lot. But, like ruby, it has a nice interface, and it'll stay out of the way. That means you can choose where you keep your notes, how you organize them, how you track them (if you do), and what editor you use to write them. So if you already have your own notes, you can just point `peter-notes` at them and start using worlds simplest (and coolest) notes-manager.

This is a cli tool, don't try to import it into some ruby source code.}
  spec.homepage      = 'https://github.com/fonsecapeter/peter-notes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = ['notes']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'manpages', '~> 0.6.1'
  spec.add_development_dependency 'bundler', '~> 1.15.4'
  spec.add_development_dependency 'pry', '~> 0.11.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'ronn', '~> 0.7.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov-console', '~> 0.4.2'
  spec.add_development_dependency 'colorize', '~> 0.8.1'
end
