# My doom emacs config

## Building

vterm:
```
sudo apt-get install libvterm-dev
```

`doom doctor` will warn about missing `vterm` until it is compiled, which will be done
automatically upon first using `vterm` (`SPC o t`) within emacs.

## Troubleshooting

On linux the maximum inotify watches can be used up. This can manifest in emacs as
treemacs errors reporting "no space left on device".
[See this SO page for help](https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached).
