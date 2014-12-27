function ssh-agent-start --description 'evals ssh-agent in a fish-friendly way'
    eval (ssh-agent -c $argv)
end
