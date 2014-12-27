function clipboard --description 'Alias for xsel. Always accesses the X clipboard.'
    xsel -b $argv
end
