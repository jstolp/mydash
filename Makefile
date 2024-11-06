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

.PHONY: setup
setup: # Setup tools required for local development.
	brew install hugo # MacOS only
	hugo version
	#git submodule update --init --recursive --remote

.PHONY: newpost
newpost: # Create a new post.
	cd stolpsys.com; hugo new posts/my-first-post.md

.PHONY: serve
serve: # Serve the site locally for testing.
	cd stolpsys.com; hugo server --baseURL "http://localhost/" --buildDrafts -v --debug

.PHONY: build # Build the site.
build:
	cd stolpsys.com; hugo --minify
