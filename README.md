# Peter Notes

Manage your notes from the commandline. This lightweight tool will stay out of the way and let you choose where you keep your notes, how you organize them, how you track them (if you do), and what editor you use to write them.

## Installation

    $ gem install peter-notes

## Usage

`notes`. Yeah.

But you can do more!

For these examples, lets assume you have the following notes:

    /Users/peter/Notes/
    |-- projects
    |   |-- jarbs.txt
    |   +-- peter_notes.txt
    +-- other
        +-- motorcycle.txt

The most common use is to simply open your notes. To do this, just run `notes` with no arguments or options to open them all.

If you want to open a single note, you can pass in a `file-glob` to specify which notes you want to open. To open just `motorcycle.txt` you can run `notes motorcycle.txt`, or `notes other/motorcycle.txt`, or even `notes motorcycle*`.

If you wanted to open all notes under `projects/` you could also use this same idea and run `notes projects`.

You also get some super-helpful optional flags:
  - `-s`, `--search=<regex>`:
  Search within notes for text matching the supplied regex.

  - `-f`, `--find=<file-glob>`:
  Seach for notes that match the supplied bash-style file glob.

  - `-l`, `--list=[<path>]`:
  List all notes or, if a `<path>` is supplied, list notes within the supplied path


## Preferences

Preferences are saved in `~/.peter-notes.yml`. There are just 2 options that you can set:

  - `editor`:
  The editor of your choice. This value will get passed to bash so make sure you use the exact name your terminal will understand.

  **Possible Values**: `[vim, subl, atom, emacs, nano]`
  (more?) I haven't tested others and dont know which work well when opening a directory. For vim I use the NerdTree plugin.

  **Default Value**: `vim`

  - `notes_dir`:
  The home of your notes. This is where `notes` will look for them.

  **Possible Values**: any valid + existing dorectory path. I use `~/GoogleDrive/Notes` because I track mine in google drive (OverGrive for linux).

  **Default Value**: `~/Notes`



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

If you're changing the man page, generate roff and html files with `bin/ronn`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fonsecapeter/peter-notes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the peter-notes project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fonsecapeter/peter-notes/blob/master/CODE_OF_CONDUCT.md).
