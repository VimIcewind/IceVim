IceVim
-------------------------------------------------------------------------------
1. The .vimrc and fonts is used in both Windows and Linux.

2. The dict, tools is used in Windows.

  You may need to change your vimpath in .vimrc if your vimpath is not
  "D:\vim" in Windows.

3. The .vim is used in both Linux and Windows.

  If you want use it in Linux, you need rename it like this:

```
cd ~
mv .vimrc .vimrc.bak
mv .vim .vim.bak
git clone https://github.com/VimIcewind/IceVim.git IceVim
cd IceVim
mv .vim/ .vimrc  ~
cd ~
vim
:PlugInstall
```

  By the way, you need to install ctags, cscope, indent, gcc, gdb, make and so on,
  or you may get some error messages.
