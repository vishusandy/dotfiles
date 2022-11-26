#!/usr/bin/env bash

# REGEX ASSERTIONS
# https://www.regular-expressions.info/lookaround.html
# https://www.rexegg.com/regex-lookarounds.html
# https://perldoc.perl.org/perlre
# https://www.geeksforgeeks.org/perl-assertions-in-regex/
alias regex-assertions='echo -e "(?<=…) is positive lookbehind assertion\n(?<!…) is negative lookbehind assertion\n(?=…) is positive lookahead assertion\n(?!…) is negative lookahead assertion\n"'
alias regex-asserts='regex-assertions'
alias regex-lookbehinds='regex-assertions'
alias regex-lookaheads='regex-assertions'
alias regex-non-capturing-groups='regex-assertions'
alias regex-non-capture-group='regex-assertions'
alias regex-non-capture='regex-assertions'

# Compression
alias bzip-usage="echo 'sudo tar -cjf archive.tar.bz2 source[s]'"
alias tar-usage="echo 'sudo tar -cf archive.tar source[s]'"

# TRANSFERING FILES
alias rsync-usage-help="echo \"sudo rsync -a --partial --noatime --exclude='/*/.gvfs' --info=progress2 --info=name0 --log-file=\\\"/home/andrew/.logs/rsync_\$\(date +%F_%R\).log\\\" SRC DEST\""
alias rsync-usage-basic-help="echo \"sudo rsync -a --partial --noatime --exclude='/*/.gvfs' --log-file=\$HOME/logs/xfer.log src/ dest/\""

alias scp-help="echo -e \"\n\
scp source destination\n\n\
To copy a file from B to A while logged into B: \\n\
    scp /path/to/file username@a:/path/to/destination \\n\
To copy a file from B to A while logged into A: \\n\
    scp username@b:/path/to/file /path/to/destination \\n\n\
You do NOT need to ssh into the computer before SCP'ing, SCP will do this automatically.\n\
To copy files while logged into a computer via SSH use cp to copy them.\
\""

alias stream-copy-help="echo -e \"\n\
Stream files to another computer using tar and ssh. The files are\n\
streamed directly from one computer to the other; they are not\n\
stored on disk between transfers, and there are no temp archives.\n\n\
Instead of an alias/function this just shows an example, as there \n\
are too many options and variations on actual usage to put into \n\
an alias/function succinctly without reducing usability.\n\n\
In the example four file/folders are specified to transfer,\n\
with an additional file specified to be excluded.\n\n\
tar -C / -cf - \\\n\
  opt/widget etc/widget etc/cron.d/widget etc/init.d/widget \\\n\
  --exclude=opt/widget/local.conf | \\\n\
  ssh otherhost tar -C / -xf -\n\n\
The tar -C changes the search path to the root of the filesystem\n\
meaning all files should be specified as absolute paths\n\
  or relative to the root.\n\
To show verbose output change the -xf at the end to -xvf\n\n\
Source:\n\
https://unix.stackexchange.com/questions/106480/how-to-copy-files-from-one-machine-to-another-using-ssh
\""
