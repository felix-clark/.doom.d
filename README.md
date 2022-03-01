# My doom emacs config

## Building emacs from source

With emacs 28 providing native compilation, it can be significantly faster to build from source.
See [this SO
page](https://emacs.stackexchange.com/questions/59538/compile-emacs-from-feature-native-comp-gccemacs-branch-on-ubuntu)
for some examples. Ensure that the flag `--with-native-compilation` is set. Native JSON
support via jansson is also very useful, so make sure those prerequisites are installed
and detected in the configuration. I recommend using gcc-10, which requires setting
`CC=gcc-10` before configuration and building. By default, emacs will be installed to
`/usr/local/`.

[This script may be more useful going forward](https://gitlab.com/mslot/src_installs/-/blob/master/emacs_install_ubuntu.sh).

## Doom prerequisites

TODO: more complete prerequisite list

### vterm

vterm on Ubuntu 20+:
```
sudo apt-get install libvterm-dev
```

It is complicated on Ubuntu 18, and I can't get it to work at the moment; on an older
machine replace `vterm` with `term` in `init.el`.

`doom doctor` will warn about missing `vterm` until it is compiled, which will be done
automatically upon first using `vterm` (`SPC o t`) within emacs.

See [https://github.com/akermu/emacs-libvterm#shell-side-configuration](the readme) for
instructions on how to configure the shell.

## Running as a systemd service

Copy (softlink may not work) `emacs.service` into `~/.config/systemd/user`. This file is
edited from the default version in the emacs master branch as the default "notify" type
did not work for me. If emacs is installed as a snap or another non-standard location
the binary paths will need to be specified exactly (i.e. `emacs` -> `/snap/bin/emacs`).

Enable the service and start for the first time with

``` sh
systemctl enable --user emacs
systemctl start --user emacs
```
If changes are made after this point, be sure to run `systemctl daemon-reload --user` to reload them.

Now use

``` sh
emacsclient -c
```

to attach to the running server and use emacs as normal. To restart the emacs server
(for instance after running `doom upgrade`), run `systemctl restart --user emacs`.

## Troubleshooting

On linux the maximum inotify watches can be used up. This can manifest in emacs as
treemacs errors reporting "no space left on device".
[See this SO page for help](https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached).
