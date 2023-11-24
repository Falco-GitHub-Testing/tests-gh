#!/bin/bash

# Set your GitHub repository information
USER="Biagio-Dipalma"
REPO="test-github-rules"
GITHUB_TOKEN="test"

# GitHub API endpoint for merged pull requests
API_ENDPOINT="https://api.github.com/repos/${USER}/${REPO}/pulls?state=closed&sort=updated&direction=desc"

# Make the API call using curl
response=$(curl -s -H "Authorization: Bearer ${TOKEN}" "${API_ENDPOINT}")

# Check if the API call was successful
if [ $? -ne 0 ]; then
  echo "Error: Unable to retrieve data from GitHub API."
  exit 1
fi

# Parse the JSON response to extract relevant information
merged_prs=$(echo "$response" | jq -r '.[] | select(.state == "closed" and .merged_at != null) | .title')

# Display the titles of merged pull requests
echo "Merged Pull Requests:"
echo "$merged_prs"
