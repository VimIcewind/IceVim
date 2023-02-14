APP           := IceVim
ICEVIM        := .vimrc
ICEDOTVIM     := .vim
VIMRC         := ~/.vimrc
NVIMRC        := ~/.config/nvim/init.vim
DOTVIM        := ~/.vim

help:
	@echo "usage: make [OPTIONS]"
	@echo "    help        Show this message"
	@echo "    vim         Install IceVim for Vim"
	@echo "    neovim      Install IceVim for NeoVim"
	@echo "    update      Update IceVim"
	@echo "    upgrade     Update IceVim and plugin"
	@echo "    uninstall   Uninstall IceVim"

vim:
	@echo -e "\033[1;34m==>\033[0m Trying to install IceVim for Vim"; \
	[ ! -f $(VIMRC) ]  && cp    $(ICEVIM) $(VIMRC)      && echo "    - Created $(VIMRC) "; \
	[ ! -f $(DOTVIM) ] && cp -r $(ICEDOTVIM) ~  && echo "    - Created $(DOTVIM) "; \
	vim  +'PlugInstall' +qall; \
	echo -e "\033[32m[✔]\033[0m Successfully installed $(APP) for Vim!"

neovim:
	@echo -e "\033[1;34m==>\033[0m Trying to install IceVim for NeoVim"; \
	mkdir -p ~/.config/nvim; \
	[ ! -f $(NVIMRC) ] && cp    $(ICEVIM) $(NVIMRC)     && echo "    - Created $(NVIMRC)"; \
	[ ! -f $(DOTVIM) ] && cp -r $(ICEDOTVIM) ~  && echo "    - Created $(DOTVIM) "; \
	nvim +'PlugInstall' +qall; \
	echo -e "\033[32m[✔]\033[0m Successfully installed $(APP) for NeoVim!"

update:
	@echo -e "\033[1;34m==>\033[0m Trying to update IceVim"; \
	git pull origin master; \
	[ -f $(VIMRC)  ]  && cp -f   $(ICEVIM) $(VIMRC)      && echo "    - Updated $(VIMRC) "; \
	echo -e "\033[32m[✔]\033[0m Successfully updated $(APP)"

upgrade:
	@echo -e "\033[1;34m==>\033[0m Trying to upgrade IceVim"; \
	git pull origin master; \
	[ -f $(VIMRC)  ]  && cp -f   $(ICEVIM) $(VIMRC)      && echo "    - Updated $(VIMRC) "; \
	vim  +'PlugUpgrade' +qall; \
	vim  +'PlugUpdate' +qall; \
	echo -e "\033[32m[✔]\033[0m Successfully upgraded $(APP)"

uninstall:
	@echo -e "\033[1;34m==>\033[0m Trying to uninstall IceVim"; \
	rm -f  $(VIMRC)            && echo "    - Removed $(VIMRC)"; \
	rm -f  $(NVIMRC)           && echo "    - Removed $(NVIMRC)"; \
	rm -rf $(DOTVIM)           && echo "    - Removed $(DOTVIM)"; \
	echo -e "\033[32m[✔]\033[0m Successfully uninstalled $(APP)"

.PHONY: help vim neovim update uninstall
