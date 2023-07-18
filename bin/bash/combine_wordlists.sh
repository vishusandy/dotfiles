#!/usr/bin/env bash

# https://stackoverflow.com/questions/2150614/concatenating-multiple-text-files-into-a-single-file-in-bash
# Combine all txt files in ~/bin/wordlists
#   
#   Why you shouldn't parse the output of the `ls` command (`ls(1)`)
#     https://mywiki.wooledge.org/ParsingLs
#   
#   https://stackoverflow.com/a/2150625
#     cat *.txt >> all.txt
#   
#   https://stackoverflow.com/a/2150794
#     cat file1 file2 file3 file4 file5 file6 > out.txt
#   
#   for i in *.txt;do cat $i >> output.txt;done
#   for i in $(ls *.txt);do cat $i >> output.txt;done
#   
#   find . -iname "*.txt" -maxdepth 1 -exec cat {} >> out.txt \; 
#   ls | grep *.txt | while read file; do cat $file >> ./output.txt; done;
#   
#   find . -type f -name '*.txt' -exec cat {} + >> output.txt
#   find . -maxdepth 1 -type f -name '*.txt' -exec cat {} + >> output.txt
#   
#   awk '1' *.txt > all.txt
#   perl -ne 'print;' *.txt > all.txt
#   
#   A more portable solution would be using fd
#   fd -e txt -d 1 -X awk 1 > combined.txt
#     -d 1 limits the search to the current directory. If you omit this option then it will recursively find all .txt files from the current directory.
#     -X (otherwise known as --exec-batch) executes a command (awk 1 in this case) for all the search results at once.
#   
#   
#   
#   
#   
#   
#   


# sort words, filtering out duplicates (there should be a `sort` option for that)
# remove all words less than 4 characters long, or containing an apostrophe (')
