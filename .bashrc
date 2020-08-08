##the bash prompt

#color palette
white=$(tput setaf 248);
orange=$(tput setaf 172);
pink=$(tput setaf 173);
green=$(tput setaf 34);
blue=$(tput setaf 61);
yellow=$(tput setaf 220); 
mosque=$(tput setaf 23);

bold=$(tput bold);
reset=$(tput sgr0);

PS1="\n\[${bold}\]"
PS1+="\[${blue}\]\u "      #username
PS1+="\[${white}\]at "     #at
PS1+="\[${pink}\]\h "     #hostname
PS1+="\[${white}\]in "      #in
PS1+="\[${orange}\]\w "     #full path (use \W for partial path)
PS1+="\[${mosque}$ ${reset}\]"          #dollar sign prompt and reset colorss
export PS1;

