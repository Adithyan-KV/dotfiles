##based on code by jccoble3 from
##<https://github.com/jcgoble3/gitstuff/blob/master/gitprompt.sh>
##
##tweaked for my needs
##license MIT as long as the original 


##the bash prompt

#color palette
white=$(tput setaf 248);
orange=$(tput setaf 172);
pink=$(tput setaf 173);
green=$(tput setaf 34);
blue=$(tput setaf 61);
yellow=$(tput setaf 178); 
mosque=$(tput setaf 23);
red=$(tput setaf 88);
olive=$(tput setaf 64);
purple=$(tput setaf 90);

#background color
bggrey=$(tput setab 239);

bold=$(tput bold);
reset=$(tput sgr0);

parse_git_branch() {
	#if stderror occurs (no git branch) get rid of the value
	#else return the branch name with * attached to it, i.e current branch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output[+]"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output[!]"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output[?]"
    [[ -n $(git stash list) ]] && output="${output}[S]"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}[P]"
    [[ -n $output ]] && output="$output"  # separate from branch name
    echo $output
}


git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;34m' # bold blue
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_state() {
    # First, get the branch name...
    local branch=$(parse_git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        # Now output the actual code to insert the branch and status
        echo -e "$state"  # last bit resets color
    fi
}

on_in_prompt(){
	#if in a git directory add echo "on" 
	#will be added to prompt as `on {branch}`
	if [[ -n $(parse_git_branch) ]]; then
		echo -e "on "
	fi
}


PS1="\n\[${bold}\]"			   		 	#newline and set everything to bold
PS1+="\[${blue}\]\u "      			 	#username
PS1+="\[${white}\]at "     			 	#at
PS1+="\[${pink}\]\h "      			 	#hostname
PS1+="\[${white}\]in "     			 	#in
PS1+="\[${orange}\]\w "    			 	#full path (use \W for partial path)
PS1+="\[${white}\]\$(on_in_prompt)"     #on
PS1+="\[${green}\]\$(parse_git_branch)" #branch
PS1+="\$(git_state)"                   #git state, uncommited changes and stuff
PS1+="\[${mosque}$ ${reset}\]"          #dollar sign prompt and reset colors
export PS1;


