# Nord color scheme
set -x FZF_DEFAULT_COMMAND "--color='fg:#e5e9f0,bg:#3b4252,hl:#81a1c1'"
set -a FZF_DEFAULT_COMMAND "--color='fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1'"
set -a FZF_DEFAULT_COMMAND "--color='info:#eacb8a,prompt:#bf6069,pointer:252'"
set -a FZF_DEFAULT_COMMAND "--color='marker:#a3be8b,spinner:#b48dac,header:#a3be8b'"

# Use fd with fzf if it is available
if type -q fd
    set -p FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude .git"
end
