#!/bin/bash

# Pompt the use fo thei username
read -p "Enter you username: " USERNAME

# Pompt the use fo thei password (without echoing it to the teminal)
read -s -p "Enter you password: " PASSWORD
echo  # Add a new line after the password input

# Git cedential store file
CREDENTIALS_FILE="$HOME/.git-credentials"

# Set up Git credentials
echo -e "https://$USERNAME:$PASSWORD@bitbucket.ipgaxis.com" > "$CREDENTIALS_FILE"

# Configue Git to use the cedential store
git config --global credential.helper "store --file=$CREDENTIALS_FILE"
git config --global credential.helper 'cache --timeout=3600'

