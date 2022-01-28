function kitty-nim -d "Launch a kitty session for a nim project"
    set -l prog "Kitty Session Manager"
    argparse --name $prog -X 1 'n/name=' 'v/verbose' -- $argv

    set -l dir $argv[1]
    if test -z $dir
        set dir (pwd)
    else if test ! -d $dir
        echo "$prog: expected directory but got $dir"
        return
    end

    set -l name $_flag_name
    if test -z $name
        set name (basename $dir)

        # Handle home directory
        if test $name = $USER
            set name "term"
        end
    end

    if test -n "$_flag_verbose"
        echo "Creating session at $dir named $name"
    end
    kitty --session ~/.config/kitty/sessions/nim --detach --directory $dir --title $name
end

