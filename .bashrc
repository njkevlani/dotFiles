# ~/.bashrc


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=10000

# TODO
# Get name@host down
# git integration on top
# get PWDdown

# From https://iwalton.com/wiki/
alias ls='ls --color=auto'
#BEGIN prompt code
function makePrompt {

    local pred="\[\033[0;31m\]"
    local pyellow="\[\033[1;33m\]"

    bold=$'\e[1m'; underline=$'\e[4m'; dim=$'\e[2m'; strickthrough=$'\e[9m'; blink=$'\e[5m'; reverse=$'\e[7m'; hidden=$'\e[8m'; normal=$'\e[0m'; black=$'\e[30m'; red=$'\e[31m'; green=$'\e[32m'; orange=$'\e[33m'; blue=$'\e[34m'; purple=$'\e[35m'; aqua=$'\e[36m'; gray=$'\e[37m'; darkgray=$'\e[90m'; lightred=$'\e[91m'; lightgreen=$'\e[92m'; lightyellow=$'\e[93m'; lightblue=$'\e[94m'; lightpurple=$'\e[95m'; lightaqua=$'\e[96m'; white=$'\e[97m'; default=$'\e[39m'; BLACK=$'\e[40m'; RED=$'\e[41m'; GREEN=$'\e[42m'; ORANGE=$'\e[43m'; BLUE=$'\e[44m'; PURPLE=$'\e[45m'; AQUA=$'\e[46m'; GRAY=$'\e[47m'; DARKGRAY=$'\e[100m'; LIGHTRED=$'\e[101m'; LIGHTGREEN=$'\e[102m'; LIGHTYELLOW=$'\e[103m'; LIGHTBLUE=$'\e[104m'; LIGHTPURPLE=$'\e[105m'; LIGHTAQUA=$'\e[106m'; WHITE=$'\e[107m'; DEFAULT=$'\e[49m';
    tabChar=$'\t'
    if [ "$UID" != "0" ]; then
        local SYMBOL="$"
        local UNAME_COLOR="\[\033[1;32m\]"
        local FINAL_COLOR="\[\033[0m\]"
        namecolor="$green"
    else
        local SYMBOL="#"
        local UNAME_COLOR="\[\033[1;31m\]"
        local FINAL_COLOR="\[\033[0;32m\]"
        namecolor="$red"
    fi
    interface=$(/usr/bin/tty | /bin/sed -e 's:/dev/::')
    PromCurTTY=$(tty | sed -e "s/.*tty\(.*\)/\1/")
    PromBLUE_BACK="\033[44m"
    BLUE_BACK="\[\033[44m\]"
    promusername="$USER"
    promhostname="$HOSTNAME"
    sedhome=$(sed 's/[][\.*^$(){}?+|/]/\\&/g' <<< "$HOME")
    if which acpi > /dev/null && acpi > /dev/null 2> /dev/null
    then
        acpiOk="1"
    else
        acpiOk="0"
    fi
    function prompt_command {
        returnStatus="$?"
        errortest=$(if [[ "$returnStatus" != "0" ]]; then echo "$returnStatus "; fi)
        currentdir=$(pwd | sed "s/${sedhome}/~/g")
        if [[ "$acpiOk" == "1" ]]
        then
            battest=$(acpi | tr ' ' '\n' | grep '%' | tr -d '%,')
            if [[ "$battest" == "100" ]]
            then
                battery=" "
            elif [[ "$battest" -gt "89" ]]
            then
                battery="$bold$green█$normal$BLACK"
            elif [[ "$battest" -gt "79" ]]
            then
                battery="$bold$green▇$normal$BLACK"
            elif [[ "$battest" -gt "69" ]]
            then
                battery="$bold$green▆$normal$BLACK"
            elif [[ "$battest" -gt "59" ]]
            then
                battery="$bold$green▅$normal$BLACK"
            elif [[ "$battest" -gt "49" ]]
            then
                battery="$bold$green▄$normal$BLACK"
            elif [[ "$battest" -gt "39" ]]
            then
                battery="$orange▃$normal$BLACK"
            elif [[ "$battest" -gt "29" ]]
            then
                battery="$bold$orange▂$normal$BLACK"
            else
                battery="$red▁$normal$BLACK"
            fi
        else
            battery=" "
        fi
        stopped=$(jobs -s | wc -l | tr -d " ")
        running=$(jobs -r | wc -l | tr -d " ")
        dateget=$(date +"%a %b %d %H:%M")
        filecount=$(ls -1 | wc -l | tr -d ' ')
        size=$(ls -lah | grep -m 1 total | /bin/sed "s/total //")
        length=$(echo "$promusername@$promhostname on $interface jobs:$running$stopped $filecount files $size   $dateget" | wc -c)
        fulllength=$(echo "$promusername@$promhostname on $interface jobs:$running$stopped $filecount files $size $currentdir   $dateget" | wc -c)
        if [[ "$fulllength" -gt "$COLUMNS" ]]
        then
            spaces=$(printf "%$((COLUMNS-length))s\n")
            echo -en "\033[s\
            \033[H\033[K"
            echo -en "$BLACK$bold$namecolor"
            echo -en "$promusername@$promhostname$normal$white$BLACK on $bold$blue$interface$red jobs:$green$running$red$stopped$aqua $filecount files $orange$size $normal$BLACK$spaces$battery $purple$dateget\033[K\n$normal$BLACK$green$currentdir \
\033[K\
\033[u\033[1A\033[1B$default$DEFAULT"
        else
            spaces=$(printf "%$((COLUMNS-fulllength))s\n")
            echo -en "\033[s\
            \033[H\033[K"
            echo -en "$BLACK$bold$namecolor"
            echo -en "$promusername@$promhostname$normal$white$BLACK on $bold$blue$interface$red jobs:$green$running$red$stopped$aqua $filecount files $orange$size $normal$BLACK$green$currentdir $spaces$battery $purple$dateget\
\033[K\
\033[u\033[1A\033[1B$default$DEFAULT"
        fi
        echo "$(date +%Y-%m-%d--%H-%M-%S)$tabChar$(hostname)$tabChar$PWD$tabChar$(history 1)" >> ~/.full_history

    }

    export PROMPT_COMMAND=prompt_command

    #Custom PS1 string (prompt)
    PS1="$pred\$errortest$pyellow\! $UNAME_COLOR$SYMBOL$FINAL_COLOR "
    export PS1;
}

makePrompt
#END prompt code
