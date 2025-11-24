#!/bin/bash

rm -rf *.sig
rm -rf arch_repo.db.* arch_repo.files*

# GPG key of user ali
KEYID="0431FA1B3A37A8D4"

# Path to ali's GPG home
HOMEDIR="/home/ali/.gnupg"

# Loop over all .zst files in current directory
for file in *.zst; do
    [ -e "$file" ] || continue   # skip if no .zst exists

    echo "Signing: $file"
    sudo -u ali gpg --homedir "$HOMEDIR" --local-user "$KEYID" --batch --yes --detach-sig "$file"
done



echo "arch_repo repo-add"
#repo-add -s -n -R pdlinux_repo.db.tar.gz *.pkg.tar.zst
repo-add -s -n -R arch_repo.db.tar.gz *.pkg.tar.zst

tar -tf arch_repo.db.tar.gz | grep /desc | wc -l

sleep 1


echo "####################################"
echo "PACKAGE Repo Updated!!"
echo "####################################"
