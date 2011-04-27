# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export USER_BASH_COMPLETION_DIR="/usr/local/etc/bash_completion.d"

# bash-completion
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home

export MANPATH=/opt/local/man:$MANPATH

export WORKON_HOME='~/www/pyapps'
#source ~/.virtualenvwrapper_bashrc

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
export EDITOR='emacs'
export VISUAL='emacs'
export GIT_EDITOR='emacs'

#other handy things
export CLICOLOR="t"

##############################################################
#                      Aliases
##############################################################
alias ls='ls -Fph '
alias sl='ls -Fph '
alias la='ls -Fphla '
alias ll='ls -Fphla '
alias more='less'
alias mroe="less"

alias node-repl='NODE_NO_READLINE=1 rlwrap node-repl'
#  misspellings
alias exti="exit"


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
    PS1="$historyBlock$userHostBlock$pathBlock $promptChar "
    PS2="$ps2arrow"
}

#--------------------------------------------------
#    Shortcut for traversing up directories
#--------------------------------------------------

function .. (){
  local arg=${1:-1};
  local dir=""
  while [ $arg -gt 0 ]; do
    dir="../$dir"
    arg=$(($arg - 1));
  done
  cd $dir >&/dev/null
}


# Call the method that initilizes the prompt
setprompt

# set the command window title to user@hostname:
PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~} - ${USER}@${HOSTNAME}\007"'
