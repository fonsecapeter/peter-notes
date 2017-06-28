# Peter Notes

Manage your notes from the console.

If you're like me, you spend most of your computing time in a terminal. You have a text-editor that's heavily customized to your liking, and you wish you could read and write everything with it. Naturally, you feel the same about your notes and, when it comes time to ditch the note-pad, you refuse to to use the more popular gui-driven apps.

But when you start looking for a console-based notes framework you're blinded by crazy features and unwilling to learn a new tool. You've also already started keeping some text files in a directory and just cd into them all the time. Eventually you write an alias and call it a day.

That's what I did. I also turned my alias into a bash function and wrote a couple more after I got tired of grepping on my own. At a certain point I got tired of writing bash and migrated to a ruby project. It was probably way more work than learning a new tool but I think it's pretty cool so whatever.

Anyway, I made this this lightweight tool to do what I wanted it to do, which isn't a lot. It's essentially `cd`, `grep`, `tree`, and `find` wrapped into some nicer syntax with a preferences file to hold the info that you don't want to keep typing. That means it'll stay out of the way and let you choose where you keep your notes, how you organize them, how you track them (if you do), and what editor you use to write them. You can even just point it at your notes and stop cding and grepping into them manually.

I made it for myself, and mostly packaged it into a ruby gem so I could keep it on all my computers/virtual machines, but if anyone else out there ever uses this, hopefully you like it. Much like Mr. Matsumoto, I think programming should be simple and linguistic, and I feel the same about the console.

## Installation

    $ gem install peter-notes

## Usage

`notes`. Yeah.

But you can do more!

Lets assume you have the following notes:

    /Users/peter/Notes/
    |-- projects
    |   |-- python
    |   |   +-- jarbs.txt
    |   +-- ruby
    |       +-- peter_notes.txt
    +-- other
        +-- motorcycle.txt

Most of the time you just want to open them. To do that, just type `notes`. You can specify your text editor and where your notes are in `~/peter-notes.yaml` (see the preferences section below).

If you want to open a specific note, you can pass in a `file-glob` to specify which notes you want to open. If you think a file glob is what happens when you spill coffee on your computer, just check this out [this](http://tldp.org/LDP/abs/html/globbingref.html) or google it (hint, you use it in bash a lot, like, when you `ls *.rb`).

If you just want to open `other/motorcycle.txt` you can run `notes "other/motorcycle.txt"`. But that's kind of lame, so you could also fo `notes "motorcycle.txt"`, or even `notes "moto*"`. If you're feeling extra crazy, you could even get away with `m*` in this case, basically if you pass a glob in, `peter-notes` will just take the first match in `--find` (see below) and open that.

If you wanted to open all notes under `projects/` you could also use this same idea and run `notes "projects"`.

That's like what 90% of what you'll ever need and no crazy macros or flags to memorize. Not bad right? Well not all flags are bad, in fact, you also get some super-helpful optional ones for the other 10%:

  - `-s`, `--search REGEX`:
  Search within notes for text matching the specified `REGEX`. If you haven't guessed, this is the [grep](http://linuxcommand.org/man_pages/grep1.html) part. Specifically, it's running `grep -r YOUR-NOTES-DIR -e REGEX`.

  - `-f`, `--find FILE-GLOB`:
  Seach for notes that match the specified file-glob. This one's running [find](http://linuxcommand.org/man_pages/find1.html) -- `find YOUR-NOTES-DIR -name FILE-GLOB`. It's a little more than that though, this will be fuzzy in that you can add some path info to your glob. For example, if you ran `notes --find "projects/*.txt"`, you'd get back both `projects/python/jarbs.txt` and `projects/ruby/peter_notes.txt`. So it's better than just find. A little.

  - `-l`, `--list [PATH]`:
  List all notes or, if a `PATH` is specified, list notes within the specified path. Bet you thought this was running `ls -r`, well it's actually running [tree](http://linuxcommand.org/man_pages/tree1.html) because it's much cooler -- `tree YOUR-NOTES-DIR/PATH`.

Oh yeah, make sure your terminal has `grep`, `find`, and `tree`. It should, but depends on how crazy your 'gear' is. Also, this is a cli tool, don't try to import it into some ruby source code.

## Preferences

Preferences are saved in `~/.peter-notes.yml`. There are just 2 options that you can set so don't freak out:

  - `editor`:
  The editor of your choice. This value will get passed to bash so make sure you use the exact name your terminal will understand.

  **Possible Values**: `[vim, subl, atom, emacs, nano]`
  (more?) I haven't tested others and dont know which work well when opening a directory. For vim I use the NerdTree plugin.

  **Default Value**: `vim`

  - `notes_dir`:
  The home of your notes. This is where `notes` will look for them.

  **Possible Values**: any valid + existing dorectory path. I use `~/GoogleDrive/Notes` because I track mine in google drive (OverGrive for linux).

  **Default Value**: `~/Notes`

That's [yaml](http://www.yaml.org/start.html) so it should look like this:

```yaml
editor: vim
notes_dir: /home/peter/Notes
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive [pry](http://pryrepl.org/) prompt.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

If you're changing the man page, generate roff and html files with `bin/ronn`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fonsecapeter/peter-notes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the peter-notes project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fonsecapeter/peter-notes/blob/master/CODE_OF_CONDUCT.md).
