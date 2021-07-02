# So that functions can be executed in the prompt.Useful for displaying git info etc.
setopt PROMPT_SUBST

# import relevant configurations from relevant files if they exist
for file in ~/.{zsh_prompt,zsh_profile,aliases}
do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file
