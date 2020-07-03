# My doom emacs config

## Building

vterm and jansson are required:

```
sudo apt-get install libvterm-dev libjansson-dev
```
The latest pretest of emacs 27 can be acquired from https://alpha.gnu.org/gnu/emacs/pretest/ .

```
./configure --with-json
make -j4
sudo make install
```

## Troubleshooting

On linux the maximum inotify watches can be used up. This can manifest in emacs as
treemacs errors reporting "no space left on device".
[See this SO page for help](https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached).
