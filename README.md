# My doom emacs config

## Building

vterm on Ubuntu 20+:
```
sudo apt-get install libvterm-dev
```
It is complicated on Ubuntu 18, and I can't get it to work at the moment.

`doom doctor` will warn about missing `vterm` until it is compiled, which will be done
automatically upon first using `vterm` (`SPC o t`) within emacs.

## Running as a systemd service

Copy (softlink may not work) `emacs.service` into `~/.config/systemd/user`. This file is
edited from the default version in the emacs master branch as the default "notify" type
did not work for me. It assumes that emacs is installed as a snap, so the binary paths
will need to be modified if this is not the case.

Enable the service and start for the first time with

``` sh
systemctl enable --user emacs
systemctl start --user emacs
```

Now use

``` sh
emacsclient -c
```

to attach to the running server and use emacs as normal.

## Troubleshooting

On linux the maximum inotify watches can be used up. This can manifest in emacs as
treemacs errors reporting "no space left on device".
[See this SO page for help](https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached).
