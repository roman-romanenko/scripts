# Theming XFCE

## To see the changes

Exacute `xfce4-panel -r`.

## Themes and Icons

* [PRO-Dark-XFCE-Edition](https://www.xfce-look.org/p/1207818)
* [Tela circle icon theme](https://www.xfce-look.org/p/1359276)

## `gtk.css`

Create or edit ` ~/.config/gtk-3.0/gtk.css` and insert or add the following:

### To pad the terminal.
```
VteTerminal, TerminalScreen, vte-terminal { 
    padding: 15px 15px 15px 15px; 
    -VteTerminal-inner-border: 15px 15px 15px 15px; 
}
```

### To customize Whiskers Manu
```
#whiskermenu-window { 
    color: transparent; 
}

#whiskermenu-window>frame {
    margin: 9px;
}

#whiskermenu-window>frame>border {
    border: none;
}

#whiskermenu-window>frame>stack>box>box>entry {
    border: none;
    padding-left: 9px;
}

#whiskermenu-window .frame { 
    padding-top: 5px;
    border: none;
    /* background-color: aqua; */
}

#whiskermenu-window button {
    margin: 0 0 3px 3px;
    padding: 3px 7px 3px 7px;
}

#whiskermenu-window treeview {
    padding: 5px;
}
```

### To customize the Windows Buttons
```
.tasklist button {
    margin-left: 2px;
}

.tasklist image { 
    margin: 0 1px 0 7px;
}
```
