##make version control info available
autoload -Uz vcs_info
precmd() {vcs_info}

## formatting the git info string
zstyle ':vcs_info:git:*' formats 'on %b'

## add ! for unstaged changes
zstyle ':vcs_info:*' unstagedstr '!'

## add + for staged changes
zstyle ':vcs_info:*' stagedstr '+'

## variables for colors
bold=%B
end_bold=%b
forest_green=%F{034}
green=%F{40}
olive=%F{76}
grey=%F{241}
beige=%F{185}
end_colors=%f

#function for displaying git info in prompt
git_status(){
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # -> (up arrow utf8) local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output[+]"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output[!]"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output[?]"
    [[ -n $(git stash list) ]] && output="${output}[S]"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}\xe2\x87\xa7"
    [[ -n $output ]] && output="$output"  # separate from branch name
    echo $output
}

# setting up zsh prompt
setopt PROMPT_SUBST
PROMPT='${bold}'                #set entire prompt to boldface
PROMPT+='${forest_green}'       #color for username
PROMPT+='%n '                   #username
PROMPT+='${grey}'
PROMPT+='at '
PROMPT+='${green}'              #color for hostname
PROMPT+='%M '                   #hostname
PROMPT+='${grey}'
PROMPT+='in '
PROMPT+='${beige}'
PROMPT+='${PWD/#$HOME/~} '
PROMPT+='${vcs_info_msg_0_} '
PROMPT+='${git_status}'
PROMPT+='${grey}'
PROMPT+='$ '
PROMPT+='${end_bold}'            #end bold face in prompt
PROMPT+='${end_colors}'          #end colors in prompt

## setting tab autocomplete to case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

echo ${git_status}



