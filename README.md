IceVim
==================================================================================================================
1. The .vimrc  is using in both Windows and Linux.

2. The vimfiles is using in Windows.

        You may need to change your vimpath in .vimrc if your vimpath is not "E:\vim" in Windows.

3. The .vim is using in Linux.

        If you want use it in Linux, you need rename it like this: 

cd ~
mv .vimrc .vimrc.bak
mv .vim .vim.bak
git clone https://github.com/VimIcewind/IceVim.git IceVim
cd IceVim
mv .vim/ .vimrc  ~
cd ~

4. By the way, you need to install ctags, indent, gcc, gdb, make and so on, or you may get some error messages.
