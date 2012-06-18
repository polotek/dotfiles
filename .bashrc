# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# bash-completion
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Don't use ^D to exit
set -o ignoreeof

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
# huge hist files aren't a problem
export HISTFILESIZE=1000000
# and huge history lists are very useful
export HISTSIZE=10000

# concurrency. mostly for compile jobs
export JOBS=3

# text editors
export EDITOR='subl'
export VISUAL='subl'
export GIT_EDITOR='vi'

#other handy things
export CLICOLOR="t"

# Aliases
source .aliases

###################################################
#  Functions
###################################################

#--------------------------------------------------
#    Initializes informative and pretty prompts
#--------------------------------------------------
function setprompt {

    #define the colors
    local    BLUE="\[\033[1;34m\]"
    local    LIGHT_GRAY="\[\033[0;37m\]"
    local    DARK_GRAY="\[\033[1;30m\]"
    local    RED="\[\033[1;31m\]"
    local    BOLD_WHITE="\[\033[1;37m\]"
    local    NO_COLOR="\[\033[0m\]"

    # The prompt will look something like this:
    #[ 9287 ][ ~ ]
    # [tkirk@tkirk] $

    # since the shell windows on some systems are white, and some are black, some of the colors need tweaking
    case "`uname`" in

        CYGWIN* | Linux* | Darwin*)
            # black background
            historyBlock="$BLUE[$LIGHT_GRAY\!$BLUE]"
            pathBlock="$BLUE[$RED\w\$(__git_ps1 '(%s)')$BLUE]"
            userHostBlock="$BLUE[$RED\u$LIGHT_GRAY"@"$RED\h$BLUE]"
            #promptChar="$BOLD_WHITE\$$LIGHT_GRAY"
            promptChar="$BOLD_WHITE\$$NO_COLOR"

            ps2arrow="$BLUE-$BOLD_WHITE> $NO_COLOR"
        ;;

        # something-with-a-white-background)
            # BOLD_WHITE background
            #historyBlock="$BLUE[ $DARK_GRAY\!$BLUE ]"
            #pathBlock="$BLUE[ $RED\w$BLUE ]"
            #userHostBlock="$BLUE[$RED\u$DARK_GRAY"@"$RED\h$BLUE]"
            #promptChar="$DARK_GRAY\$$NO_COLOR"

            #ps2arrow="$BLUE-$DARK_GRAY> $NO_COLOR"
        #;;

        *)
            unameString=`uname`
            echo "Unknown environment detected, not setting pretty prompt.  Edit .bashrc to account for $unameString."
            return
        ;;

    esac

    # prompt structure
    PS1="$userHostBlock$pathBlock $promptChar "
    PS2="$ps2arrow"
}

# Call the method that initilizes the prompt
setprompt

# set the command window title to user@hostname:
PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~} - ${USER}@${HOSTNAME}\007"'
