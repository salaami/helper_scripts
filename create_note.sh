#!/bin/bash

# Function to calculate the hash of a string (filename)
hash_filename() {
  echo -n "$1" | cksum | awk '{print $1}'
}

# Get current date
current_date=$(date +"%Y-%m-%d")
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Get the filename from the first argument
filename="$1"

# Ensure filename is provided
if [ -z "$filename" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Calculate the hash of the filename
file_hash=$(hash_filename "$filename")

# Create the markdown content
content="---
tags:
id: $file_hash
created: $current_time
modified: $current_time
template-type: Default
template-version: \"1.0\"
---

# $filename

## Source

## References
"

# Write the content to the file
echo "$content" >"/home/salem/Documents/Documentation/obsidian-vault-salem/1 Projects/$filename.md"

echo "Note created: $filename.md"
