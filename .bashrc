# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't use ^D to exit
set -o ignoreeof

# turn on minor directory spellchecking for `cd`
shopt -s cdspell

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
# huge hist files aren't a problem
export HISTFILESIZE=1000000
# and huge history lists are very useful
export HISTSIZE=100000

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

alias emacs="open -a /Applications/MacPorts/Emacs.app"
alias visualvm="/Users/marco/bin/visualvm/bin/visualvm --jdkhome /System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home/"
alias mysqlstart="sudo launchctl load -w /Library/LaunchDaemons/org.macports.mysql5.plist"
alias mysqlstop="sudo launchctl unload -w /Library/LaunchDaemons/org.macports.mysql5.plist"
#  misspellings
alias exti="exit"
alias mroe="less"

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
            pathBlock="$BLUE[$RED\w$BLUE]"
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

#--------------------------------------------------
#    Extracts most files, mostly
#--------------------------------------------------

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1    ;;
      *.tar.gz)   tar xzf $1    ;;
      *.bz2)      bunzip2 $1    ;;
      *.rar)      rar x $1      ;;
      *.gz)       gunzip $1     ;;
      *.tar)      tar xf $1     ;;
      *.tbz2)     tar xjf $1    ;;
      *.tgz)      tar xzf $1    ;;
      *.zip)      unzip $1      ;;
      *.Z)        uncompress $1 ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#--------------------------------------------------
#    Greps ps -e for you
#--------------------------------------------------

psg() {
  if [ ! -z "$1" ] ; then
    ps aux | grep -i "$1" | grep -v grep
  else
    echo "Need a proces name to grep processes for"
  fi
}

#--------------------------------------------------
#    Greps history
#--------------------------------------------------

histg() {
  if [ ! -z "$1" ] ; then
    history | grep "$1" | grep -v histg
  else
    echo "Need a command to grep history for"
  fi
}

# Call the method that initilizes the prompt
setprompt

# set the command window title to user@hostname:
PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~} - ${USER}@${HOSTNAME}\007"'
