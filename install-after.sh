#!/bin/sh
# Copyright (C) YYYY Firstname Lastname; Licensed under GPL v2 or later
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst <caller-prg> <PKG> <VER>
#
# This script is run after [install] command. NOTE: Echo all messages
# with ">> " prefix".

PATH="/sbin:/usr/sbin/:/bin:/usr/bin:/usr/X11R6/bin"
LC_ALL="C"

set -e

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}
    caller=$2
    pkg=$3
    ver=$4

    if [ ! "$root"  ] || [ ! -d "$root" ]; then
        echo "$0: [ERROR] In $(pwd) no such directory: '$root'" >&2
        return 1
    fi

    root=$(echo $root | sed 's,/$,,')  # Delete trailing slash
    etcdir=$root/etc

    echo ">> Install /etc default"
    Cmd install -m 755 -d $etcdir/tirc
    Cmd install -m 644 CYGWIN-PATCHES/tircrc $etcdir/tirc
}

Main "$@"

# End of file
