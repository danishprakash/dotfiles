.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "symlinking zsh config files"
	@for file in $(shell find $(CURDIR) -type f -name ".zsh.*"); do \
		f=$$(basename $$file); \
		ln -fs $$file $(HOME)/$$f; \
	done; \

	@echo "symlinking nvim config files"
	@mkdir -p $(HOME)/.config/nvim
	for file in $(shell find $(CURDIR)/.config/nvim -type f -name "*.vim"); do \
		f=$$(basename $$file); \
		ln -fs $$file $(HOME)/.config/nvim/$$f; \
	done; \

.PHONY: help
## help: print this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'
