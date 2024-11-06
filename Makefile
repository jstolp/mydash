default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@echo $@
	#   Usage [MyDash Makefile]:
	#
	#       make <target> [ENV=testing]
	#                           Specify ENV=testing to run artisan using the .env.testing config
	#
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: all-versions
all-versions: # Show all versions of tools used in this project.
	@docker --version
	@hugo version
	@echo "\nNPM version:"
	@npm --version
	@echo "\nNode.js version:"
	@node --version
	@php --version
	@go version
	@echo "\n All versions... \n\n"

.PHONY: setup-hugo
setup-hugo: # Setup tools required for local development - MacOSX.
	brew install hugo # MacOS only
	hugo version
	#git submodule update --init --recursive --remote

.PHONY: stolpsys-newpost
stolpsys-newpost: # Create a new post.
	cd stolpsys.com; hugo new content content/posts/my-new-post.md

.PHONY: stolpsys-serve
stolpsys-serve: # Serve the site locally for testing.
	open http://localhost:1313/
	cd stolpsys.com; hugo server --baseURL "http://localhost:1313/" --buildDrafts -v --debug


.PHONY: stolpsys-build # Build the site.
stolpsys-build:
	cd stolpsys.com; hugo --minify
