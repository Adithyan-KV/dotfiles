##make version control info available
autoload -Uz vcs_info
precmd() {vcs_info}


## variables for colors
bold=%B
end_bold=%b
forest_green=%F{034}
green=%F{40}
olive=%F{76}
grey=%F{241}
beige=%F{185}
brown=%F{130}
end_colors=%f

## formatting the git info string
zstyle ':vcs_info:*' enable git   
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '?'
zstyle ':vcs_info:git:*' formats 'on %F{130} %b[%c][%u]'

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
PROMPT+='${grey}'
PROMPT+='${vcs_info_msg_0_} '
PROMPT+='${grey}'
PROMPT+='$ '
PROMPT+='${end_bold}'            #end bold face in prompt
PROMPT+='${end_colors}'          #end colors in prompt

## setting tab autocomplete to case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'



