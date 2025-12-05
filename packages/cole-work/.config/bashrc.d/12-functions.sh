refresh-gh-token() {
  if command -v gh &>/dev/null; then
    gh auth refresh -h github.com -s repo,read:org
    
    # Find all npmrc files in the home directory and its subdirectories
    local npmrc_files
    npmrc_files=$(find "$HOME/projects" -maxdepth 4 -name ".npmrc" 2>/dev/null)

    echo "Found .npmrc files:"
    echo "$npmrc_files"
  
    for file in $npmrc_files; do
      # Replace auth token in each .npmrc file
      echo "Updating auth token in $file"
      gh auth token -h github.com | xargs -I {} sed -i.bak "s/^\/\/npm.pkg.github.com\/:_authToken=.*/\/\/npm.pkg.github.com\/:_authToken={}/" "$file" 
    done
  else
    echo "GitHub CLI (gh) is not installed."
  fi
}
