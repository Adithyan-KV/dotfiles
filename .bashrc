##the bash prompt

#color palette
white=$(tput setaf 248);
orange=$(tput setaf 172);
pink=$(tput setaf 173);
green=$(tput setaf 34);
blue=$(tput setaf 61);
yellow=$(tput setaf 220); 
mosque=$(tput setaf 23);

#background color
bggrey=$(tput setab 239);

bold=$(tput bold);
reset=$(tput sgr0);

parse_git_branch() {
	#if stderror occurs (no git branch) get rid of the value
	#else return the branch name with * attached to it, i.e current branch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\n\[${bold}\]"
PS1+="\[${blue}\]\u "      #username
PS1+="\[${white}\]at "     #at
PS1+="\[${pink}\]\h "     #hostname
PS1+="\[${white}\]in "      #in
PS1+="\[${orange}\]\w "     #full path (use \W for partial path)
PS1+="\[${green}\]\$(parse_git_branch)"
PS1+="\[${mosque}$ ${reset}\]"          #dollar sign prompt and reset colorss
export PS1;


