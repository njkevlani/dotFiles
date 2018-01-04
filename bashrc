# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias i3cheatsheet='egrep ^bind ~/.config/i3/config | cut -d '\'' '\'' -f 2- | sed '\''s/ /\t/'\'' | column -ts $'\''\t'\'' | pr -2 -w 160 -t | less'
alias ls='ls --color=auto'
alias grep='grep --color'

HISTSIZE=10000

#PS1=$'\[\033[01;32m\][\[\033[01;31m\]$?\[\033[01;32m\]]-[\[\033[01;94m\]\w\[\033[01;32m\]]-[\[\033[01;94m\]\!\[\033[01;32m\]]-λ\[\033[0;0m\] '

# PS1=$'\[\033[01;32m\][
# \[\033[01;31m\]$?
# \[\033[01;32m\]]-[
# \[\033[01;94m\]\w
# \[\033[01;32m\]]-[
# \[\033[01;94m\]\!
# \[\033[01;32m\]]-λ
# \[\033[0;0m\] '


ESC="$(echo -en '\e')"
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
PURPLE="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
NORMAL="${ESC}[0m"
BOLD="${ESC}[1m"
RESET="\e[0m"

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "${GREEN}━[${BLUE}${BRANCH}${RED}${STAT}${GREEN}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits="${YELLOW}>${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="${RED}*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="${GREEN}+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="${YELLOW}?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="${RED}x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="${RED}!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`    
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "${GREEN}━[ ${BLUE} ${BRANCH}${RED}${STAT} ${GREEN}]"
    else
        echo ""
    fi
}

function Last_Command(){
	Last=`echo $?`
	if [ ! "${Last}" == "0" ]
    then       
        echo "${GREEN}━[ ${RED}${Last}${GREEN} ]"
    else
        echo "${GREEN}━[ ${BLUE}${Last}${GREEN} ]"
    fi
}


function _prompt(){
	LAST_COMMAND=`Last_Command`
	FOLDER_SIZE=`lsbytesum`
	GIT_STATE=`parse_git_branch`
	VTE_PWD_THING="\[$(__vte_osc7)\]"		
	export PS1="\[${GREEN}\]\[${BOLD}\]┏━[\[${BLUE}\]\u\[${GREEN}\]@\[${BLUE}\]\h\[${GREEN}\]]━[\[${BLUE}\]\w ${FOLDER_SIZE}\[${GREEN}\]]${GIT_STATE}${LAST_COMMAND}
\[${GREEN}\]┗━[\[${BLUE}\]\!\[${GREEN}\]]━━`echo -e '\ue0b0'`\[${RESET}\]"

}

PROMPT_COMMAND=_prompt



#ᐅ
#▶
# Last command remaining
# Size of folder remaining