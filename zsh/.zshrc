
# import relevant configurations from relevant files if they exist
for file in ~/.{zsh_prompt,zsh_profile,aliases}
do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file
