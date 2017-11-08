set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_show_informative_status 'yes'

# Status Chars
set __fish_git_prompt_char_dirtystate ' ⚡'
set __fish_git_prompt_char_stagedstate ' → '
set __fish_git_prompt_char_stashstate ' ↩ '
set __fish_git_prompt_char_untrackedfiles ' … '
set __fish_git_prompt_char_upstream_ahead ' ↑ '
set __fish_git_prompt_char_upstream_behind ' ↓ '
set __fish_git_prompt_char_stateseparator ' |'

function fish_right_prompt --description 'Returns a git statusline for display in the prompt.'
    __fish_git_prompt
end
