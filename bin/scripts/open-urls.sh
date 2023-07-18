#!/usr/bin/env bash

# Find all urls in the file and make an html document out of it, and then open the html file
#   The html file can be opened by the default browser by just specifying the filename as a command like
#     '/home/andrew/code/my-snippets/web/html5-template.html'

# Multiple URL File Examples
# /home/andrew/code/UNSORTED-TODO/unsorted code/kvm notes.urls.txt
# /home/andrew/home/server/linux/systemd/clear systemd logs - free disk space and routine maintenance.urls.txt
# /home/andrew/home/archived/server/certbot/letsencrypt wildcard cert and automating with cloudflare.urls.txt
# /home/andrew/dev/archive/home server/self hosting/self-hosting notes 2020.urls.txt
# /home/andrew/MyDocs/.unsorted/Documents_archive/Shared Documents/dev/cloud/Minio - Kubernetes and Containers.urls.txt
# /home/andrew/Documents/dev/regex/regex links.urls.txt
# 
# 
# This works but it doesn't do exactly what I want
#   echo -e "https://docs.min.io/docs/minio-deployment-quickstart-guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\n" | grep -o -P '^(?<=)https://.*(?=\s*)$'# 
#     grep -P -o '^(?<=)https://.*(?=\s*)$'
# Match only the URL portions (stopping at a space that doesn't have a backslash before it)
#   echo -e "https://docs.min.io/docs/minio-deployment-quickstart\ guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\n" | grep -P -o 'https://([^ ]|(?<=\\) )*'
#     grep -P -o 'https://([^ ]|(?<=\\) )*'
# 
# Allow any whitespace to be escaped by a backslash, and if not that's the end of the URL.  Test with (backslash)(tab)
#   echo -e $'https://docs.min.io/docs/minio-deployment-quickstart\ guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\tTHIS-IS-NO\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\\\tthis-works-yea\n' | grep -P -o 'https://([^\s]|(?<=\\)\s)*'
#     grep -P -o '(https|http|ftp|file|)://([^\s]|(?<=\\)\s)*'
# 
#  # https://en.wikipedia.org/wiki/List_of_URI_schemes
#  # Other schemes include:
# 
# 
# 
# 
# 
# # Iterate lines in a variable
# while read -r URL; do echo "$URL"; done <<< "$URLS"
# 
# # Specify text to search, find all URLs, and iterate over each URL
# while read -r URL; do echo "$URL"; done <<< "$(echo -e $'https://docs.min.io/docs/minio-deployment-quickstart\ guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\tTHIS-IS-NO\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\\\tthis-works-yea\n' | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"
# 
# # Find all URLs in a string variable then iterate through the URLs
# while read -r URL; do echo "$URL"; done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"
# 
#   # Same as above but on multiple lines
#   while read -r URL; do
#     echo "$URL"
#   done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"

# --ECHO URLS------
# while read -r URL; do
#   echo "$URL"
# done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"


if [[ ! "$1" || ! -f "$1" ]]; then
  exit 1
fi


while read -r URL; do
  xdg-open "$URL"
done <<< "$(grep -P -m 20 -o 'https://([^\s]|(?<=\\)\s)*' "$1")"
# done <<< "$(echo -e "$TEXT" | grep -P -m 20 -o 'https://([^\s]|(?<=\\)\s)*')"
