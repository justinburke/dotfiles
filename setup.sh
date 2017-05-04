#!/bin/bash
# Setup symlinks for first use.
#
# To test:
#    mkdir $HOME/testdir
#    dotfiles/setup.sh -t $HOME/testdir   # note: full path (not relative) is required here.
#
# Dry-run:
#    dotfiles/setup.sh
#
# Actual run:
#    dotfiles/setup.sh -e


dotfiles=$(dirname $(readlink -f $0) )
targetdir=$HOME
dryrun=1

while getopts "et:" opt; do
    case $opt in
        e)
            echo "Disabling dry-run mode... This is for reals... CTRL-C to cancel"
            # Sadness, `seq 5 1` doesn't work on some platforms...
            echo "5 ..."; sleep 1
            echo "4 ..."; sleep 1
            echo "3 ..."; sleep 1
            echo "2 ..."; sleep 1
            echo "1 ..."; sleep 1
            dryrun=0
            ;;
        t)
            targetdir=$OPTARG
            echo "Using target directory of: $targetdir"
            ;;
        \?)
            echo "Invalid argument -$OPTARG"; exit 1
            ;;
    esac
done

function process_file()
{
    dotfile="$1"

    target="$targetdir/$dotfile"
    if [ -e "$target" ]; then
        echo "Found existing file ${target}. Will backup."
        cmd="mv ${target} ${target}.orig"

        if [ $dryrun -eq 0 ]; then
            echo "Executing: $cmd"
            $cmd || exit 1
        else
            echo "Would execute: $cmd"
        fi
    fi

    cmd="ln -s $dotfiles/$dotfile $target"

    if [ $dryrun -eq 0 ]; then
        echo "Executing: $cmd"
        $cmd || exit 1
    else
        echo "Would execute: $cmd"
    fi

    echo
}

process_file ".Xmodmap"
process_file ".bash_profile"
process_file ".bashrc"
process_file ".conkyrc"
process_file ".gitconfig"
process_file ".inputrc"
process_file ".screenrc"
process_file ".vimrc"

if [ $dryrun -eq 0 ]; then mkdir -p "$targetdir/.fluxbox"; fi
process_file ".fluxbox/keys"
process_file ".fluxbox/menu"
process_file ".fluxbox/startup"

if [ $dryrun -eq 0 ]; then mkdir -p "$targetdir/.gnupg"; fi
process_file ".gnupg/gpg-agent.conf"

echo "Done."

# vi:et:sw=4:ts=4
