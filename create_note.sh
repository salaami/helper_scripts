#!/bin/bash

# Function to calculate the hash of a string (filename)
hash_filename() {
  echo -n "$1" | cksum | awk '{print $1}'
}

# Get current date
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Get the filename from the first argument
filename="$1"

# Ensure filename is provided
if [ -z "$filename" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Function to capitalize the first character of a string if it's a letter
capitalize_first_letter() {
  echo "$1" | sed -E 's/^([a-z])/\U\1/'
}

# Capitalize the first letter of the filename
capitalized_filename=$(capitalize_first_letter "$filename")

# Calculate the hash of the filename
file_hash=$(hash_filename "$filename")

# Create the markdown content
content="---
tags: []
id: $file_hash
created: $current_time
modified: $current_time
template-type: Project
template-version: \"1.0\"
---

# $capitalized_filename

## Source

## References
"
# Expand the tilde to the home directory
output_dir="$HOME/Documents/Documentation/obsidian-vault-salem/1 Projects"

# Write the content to the file
echo "$content" >"$output_dir/$filename.md"

echo "Note created: $filename.md"
