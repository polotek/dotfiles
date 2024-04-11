eval "$(/opt/homebrew/bin/brew shellenv)"

###################################################
# Variables
###################################################

# Don't put duplicate lines in the history.
set -gx HISTCONTROL ignoredups
# huge hist files aren't a problem
set -gx HISTFILESIZE 1000000
# and huge history lists are very useful
set -gx HISTSIZE 10000

fish_add_path $HOME/bin

###################################################
# Other settings
###################################################

source $HOME/.aliases

###################################################
# Variables
###################################################

if status is-interactive
    # Commands to run in interactive sessions can go here
end
