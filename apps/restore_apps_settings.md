# Gnome terminal

## Profile

* text
 custom fonts Monospace 14

 Cursor shape block

 sound turn on terminal bell

 * Colours

 Build-in schemes Black on light yellow

 Build-in schemes Black on light yellow

 Use transparent background none

 Palette Buidt-in scheme GNOME

```sh
# backup all dconf
cp -r ~/.config/dconf/user ~/.config/dconf/user.bak
# create bkp
dconf dump /org/gnome/terminal/ > gnome_terminal_settings_backup.txt
# reset machine defautls
dconf reset -f /org/gnome/terminal/
# load saved settings
dconf load /org/gnome/terminal/ < gnome_terminal_settings_backup.txt
```


# BAT

`ln -fs $PWD/bat_config ~/.config/bat/config`
