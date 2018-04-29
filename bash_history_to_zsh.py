#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Adapted from https://gist.github.com/muendelezaji/c14722ab66b505a49861b8a74e52b274
#
# $ cat ~/.bash_history | bash-history-to-zsh-history >> ~/.zsh_history

import sys
import time

def main():
    timestamp = None
    for line in sys.stdin.readlines():
        line = line.rstrip('\n')
        if line.startswith('#') and timestamp is None:
            t = line[1:]
            if t.isdigit():
                timestamp = t
                continue
        else:
            sys.stdout.write(': %d:0;%s\n' % (timestamp or time.time(), line))
            timestamp = None


if __name__ == '__main__':
    main()
