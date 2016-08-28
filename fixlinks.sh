#!/bin/bash
# Update symlinks from old locations to new.

basedir=$HOME
dryrun=1

while getopts ":e" opt; do
    case $opt in
        e)
            echo "Disabling dry-run mode... This is for reals... CTRL-C to cancel"
            for i in `seq 5 1`; do echo "$i ..."; sleep 1; done
            dryrun=0
            ;;
        \?)
            echo "Invalid argument -$OPTARG"; exit 1
            ;;
    esac
done

function process_file()
{
    target="$1"
    old_location="$2"
    new_location="$3"

    dotfile="$(basename $target)"
    
    echo "Checking dotfile $target. Old location $old_location, new location $new_location, dotfile $dotfile"
    if [ ! -L "$target" ]; then
        echo "Symlink $target not found."; echo
        return
    fi

    echo "Found old symlink $target -> $(readlink $target)"
    if [ $(readlink "$target") != "$old_location" ]; then
        echo "Symlink points to custom location. Skipping."; echo
        return
    fi

    if [ ! -e "$new_location" ]; then
        "ERROR: Expected new dotfile at location: $new_location"
        exit 1
    fi

    cmd="ln -sf $new_location $target"

    if [ $dryrun -eq 0 ]; then
        echo "Executing: $cmd"
        $cmd || exit 1
    else
        echo "Would execute: $cmd"
    fi
    echo
}

if [ "$PWD" != "$basedir" ]; then
    echo "ERROR: you need to run this program from directory $basedir"
    exit 1
fi

process_file "$basedir/.Xmodmap"       "dotfiles/Xmodmap.dotfile"            "dotfiles/.Xmodmap"
process_file "$basedir/.inputrc"       "dotfiles/inputrc.dotfile"            "dotfiles/.inputrc"
process_file "$basedir/.bash_profile"  "dotfiles/bash/bash_profile.dotfile"  "dotfiles/.bash_profile"
process_file "$basedir/.bashrc"        "dotfiles/bash/bashrc.dotfile"        "dotfiles/.bashrc"
process_file "$basedir/.conkyrc"       "dotfiles/conkyrc"                    "dotfiles/.conkyrc"

process_file "$basedir/.fluxbox/keys"     "dotfiles/fluxbox/keys"      "dotfiles/.fluxbox/keys"
process_file "$basedir/.fluxbox/menu"     "dotfiles/fluxbox/menu"      "dotfiles/.fluxbox/menu"
process_file "$basedir/.fluxbox/startup"  "dotfiles/fluxbox/startup"   "dotfiles/.fluxbox/startup"

process_file "$basedir/.gnupg/gpg-agent.conf" "dotfiles/gnupg/gpg-agent.conf" "dotfiles/.gnupg/gpg-agent.conf"

process_file "$basedir/.screenrc" "dotfiles/screen/screenrc.dotfile" "dotfiles/.screenrc"
process_file "$basedir/.vimrc"    "dotfiles/vim/vimrc.dotfile"       "dotfiles/.vimrc"

echo "!!!! Don't forget to update bash history in this session:"
echo "export HISTSIZE=100000"
echo "export HISTFILESIZE=500000"
echo "OR export HISTFILE="
echo
echo "Done."

# vi:et:sw=4:ts=4
