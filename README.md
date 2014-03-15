IceVim
======
The .vimrc  is using in both Windows and Linux. The vimfiles is using in Windows. 
You may need to change your vimpath if your vimpath is not "E:\vim" in Windows.
If you want use it in Linux, you need rename it like this: 

cd ~
rm -rf .vimrc .vim
git clone https://github.com/VimIcewind/IceVim.git IceVim
cd IceVim
mv vimfiles/.vimrc  ~
cd ~
mv vimfiles .vim
mv .vim ~
rm -rf IceVim

By the way, you need to install ctags, indent, gcc, gdb, make and so on, or you may get some error messages.

