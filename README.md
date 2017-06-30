# Peter Notes [![Gem Version](https://badge.fury.io/rb/peter-notes.svg)](https://badge.fury.io/rb/peter-notes)  <a href="https://travis-ci.org/fonsecapeter/peter-notes"><img src="https://travis-ci.org/fonsecapeter/peter-notes.svg?branch=master"></img></a>

Manage your notes from the console. ([ruby gem](https://rubygems.org/gems/peter-notes/))

If you're like me, you spend most of your computing time in a terminal. You have a text-editor that's heavily customized to your liking, and you wish you could read and write everything with it. Naturally, when it comes time to ditch the paper note-pad, you refuse to to use the more popular gui-driven apps.

But when you start looking for a console-based notes framework you're blinded by crazy features and unwilling to learn a new tool. You've also already started keeping your notes in some text files and don't want to have to start over.

Anyway, I went through the same thing and made this this lightweight tool (originally from some aliases in my bashrc) to do what I wanted it to do, which isn't a lot. But, like ruby, it has a nice interface, and it'll stay out of the way. That means you can choose where you keep your notes, how you organize them, how you track them (if you do), and what editor you use to write them. So if you already have your own notes, you can just point `peter-notes` at them (see preferences below) and start using worlds simplest (and coolest) notes-manager.

## Installation

    $ gem install peter-notes

## Usage

`notes`. Yeah.

But you can do more!

Lets assume you have the following notes:

    ~/Notes
    |-- projects
    |   |-- python
    |   |   +-- jarbs.txt
    |   +-- ruby
    |       +-- peter_notes.txt
    +-- other
        +-- motorcycle.txt

Most of the time you just want to open them. To do that, type `notes`. You can specify your text editor and where your notes are in `~/peter-notes.yaml` (see the preferences section below). This will basically `cd` into your notes and open them all with `YOUR-EDITOR ./`. Some editors don't super work when you open a directory, but I use vim with [NerdTree](https://github.com/scrooloose/nerdtree) and I'm sure other editors have similar plugins.

If you want to open a specific note, you can pass in a `file-glob` to specify which notes you want to open. If you think a file glob is what happens when you spill coffee on your computer, just check this out [this](http://tldp.org/LDP/abs/html/globbingref.html) or google it (hint, you use it in bash a lot, like, when you `ls *.rb`).

Now, lets say you want to open `other/motorcycle.txt`. You could run `notes "other/motorcycle"`. But that's kind of lame, so you could also do `notes "motorcycle"`, or even `notes "moto*"`. If you're feeling extra crazy, you could get away with `m*` here. Basically if you pass a glob in, `peter-notes` will just take the first match from `--find` (see below) and open that.

If you wanted to open all notes under `projects/` you could also use this same idea and run `notes "projects"`.g
g
The close observer will have noted that I'm never adding `.txt` to my commands. That's not  because `peter-notes` requires `.txt` files. In fact, you can use markdown or whatever kind of files you want, `peter-notes` will just totally ignore file extensions by default and only ever look at the file name. If you prefer to type file extensions, just add `ignore_extension?: false` to your `~/.peter-notes.yml`.

That's like what 90% of what you'll ever need and no crazy macros or flags to memorize. Not bad right? Well not all flags are bad, in fact, you also get some super-helpful optional ones for the other 10%:

  - `-s`, `--search REGEX`:
  Search within notes for text matching the specified `REGEX`, ex: `notes --search ".*TODO.*"`. This isn't magic, it's just [grep](http://linuxcommand.org/man_pages/grep1.html). Specifically, it's running `grep -r YOUR-NOTES-DIR -e REGEX`.

  - `-f`, `--find FILE-GLOB`:
  Seach for notes that match the specified file-glob. This one's running [find](http://linuxcommand.org/man_pages/find1.html) -- `find YOUR-NOTES-DIR -name FILE-GLOB`. It's a little more than that though, this will be fuzzy in that you can add some path info to your glob. For example, if you ran `notes --find "projects/*"` (or `notes --find "pro/*"`), you'd get back both `projects/python/jarbs.txt` and `projects/ruby/peter_notes.txt`. So it's better than just find. A little.

  - `-l`, `--list [PATH]`:
  List all notes or, if a `PATH` is specified, list notes within the specified path. Bet you thought this was running `ls -R`, well it's actually running [tree](http://linuxcommand.org/man_pages/tree1.html) because it's much cooler -- `tree YOUR-NOTES-DIR/PATH`.

Oh yeah, make sure your terminal has `grep`, `find`, and `tree`. It should, but depends on how crazy your 'gear' is. Also, this is a cli tool, don't try to import it into some ruby source code.

## Preferences

Preferences are saved in `~/.peter-notes.yml`. There are just 333 options that you can set so don't freak out:

  - `editor`:
  The editor of your choice. This value will get passed to bash so make sure you use the exact name your terminal will understand.

  **Possible Values**: `[vim, subl, atom, emacs, nano]`
  (more?) I haven't tested others but I know they're out there.

  **Default Value**: `vim`

  - `notes_dir`:
  The home of your notes. This is where `notes` will look for them.

  **Possible Values**: any valid + existing dorectory path. I use `~/GoogleDrive/Notes` because I track mine in google drive (OverGrive for linux).

  **Default Value**: `~/Notes`

  - `ignore_extension?`:
  Whether or not you want `peter-notes` to ignore file-type extensions.

  **Possible Values**: `[true, false]`

  **Default Value**: `true`

That's [yaml](http://www.yaml.org/start.html) so it should look like this:

```yaml
editor: vim
notes_dir: /home/peter/Notes
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive [pry](http://pryrepl.org/) prompt.

If you're changing the man page, generate roff and html files with `bin/ronn`.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, first update the version number in `lib/peter_notes/version.rb`, then build the gem with `bundle exec rake build`. Install locally and confirm nothing broke, push a commit [Major, Minor, Patch] version bump. Now you can push the `.gem` file to [rubygems.org](https://rubygems.org) with `gem push pkg/peter-notes-VERSION.gem`. Throw a git tag on there `bin/tag`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fonsecapeter/peter-notes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the peter-notes project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fonsecapeter/peter-notes/blob/master/CODE_OF_CONDUCT.md).
