# DotCSS

DotCSS is a native Safari App Extension for loading files from `~/.css`
based on the current webpage. This is a replacement for the [dotcss
server](https://github.com/stewart/dotcss) since Safari doesn't happily
allow cross origin localhost loads.

# Installation

Currently I'm not distributing a code signed version of this app +
extension. Unfortunately Safari makes using un-signed extensions a huge
pain, since the ability to load them is reset each launch.

To install this yourself, you'll need to clone this repo, and change the
development team to something of your own that will produce a valid
signature. You'll also have to change the bundle ID to do so.

Once you've changed the development team and built, you can archive the
`.app`, and move it to your Applications directory. Then you can enable
the extension from Safari's preferences. You may need to run the `.app`
once for it to show up in the Safari preferences.
