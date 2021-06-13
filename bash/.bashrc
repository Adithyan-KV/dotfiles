#uses some snippets from mathiasbynens dotfiles
#<https://github.com/mathiasbynens/dotfiles/blob/main/.bash_profile>

#if files exist, load files for bash prompt, aliases and paths
for file in ~/.{path,bash_prompt,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

##Adding color to different outputs on ls
LS_COLORS='rs=0:di=1;34:';
export LS_COLORS

##Run neofetch at start
neofetch --colors 1 9 9 9 7 7 7 --ascii_colors 1
