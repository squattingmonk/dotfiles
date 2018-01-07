function fzf-locate
    xdg-open (locate * | fzf -e)
end    
