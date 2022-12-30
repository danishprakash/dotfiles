.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "symlinking config for:"
	@echo "* zsh"
	@for file in $(shell find $(CURDIR) -type f -name ".zsh.*"); do \
		f=$$(basename $$file); \
		ln -fs $$file $(HOME)/$$f; \
	done; \

	@echo "* nvim"
	@mkdir -p $(HOME)/.config/nvim
	for file in $(shell find $(CURDIR)/.config/nvim -type f -name "*.vim"); do \
		f=$$(basename $$file); \
		ln -fs $$file $(HOME)/.config/nvim/$$f; \
	done; \

test:
	@echo "* skhd"
	mkdir -p $(HOME)/.config/skhd
	file=$(CURDIR)/.config/skhd/skhdrc
	echo $$file
	base=$$(basename $$file)
	ln -fs $$file $(HOME)/.config/skhd/$$base

.PHONY: help
## help: print this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'
