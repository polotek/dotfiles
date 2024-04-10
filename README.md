## Pre-requisites

You need **git** and **homebrew** installed and in your path. Consider running [strap](https://strap.mikemcquaid.com/) to get everything setup.

## Installation

Note: If you use `strap.sh`, and it runs successfully, it should do all of these things for you.

* Install the dependencies in `Brewfile`. If you use strap.sh, it will do this for you.
* Run `scripts/setup`. It should do the following:
   * Copy all of the .dotfiles to `~/` (home dir)
   * Copy bin files to `~/bin` (create if necessary)
