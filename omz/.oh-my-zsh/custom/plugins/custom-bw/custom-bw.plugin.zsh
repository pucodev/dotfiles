unalias bw 2>/dev/null

# Detect bw command
bwbin() {
  if command bw >/dev/null 2>&1; then
    command bw "$@"
  elif flatpak info com.bitwarden.desktop >/dev/null 2>&1; then
    command flatpak run --command=bw com.bitwarden.desktop "$@"
  else
    echo "❌ bw command not found"
    return 1
  fi
}

# Unlock bandwidth and set the variable for `BW_SESSION`.
bwkey() {
  if [[ -z "$BW_SESSION" ]]; then
    echo "🔓 Unlocking Bitwarden..."
    local session
    session="$(bwbin unlock --raw)"

    if [[ -n "$session" ]]; then
      export BW_SESSION="$session"
      echo "✅ Bitwarden unlocked"
    else
      echo "❌ Failed to unlock Bitwarden. Please try again"
      return 1
    fi
  fi
}

# Wrapper for the 'bw' command that automatically unlocks Bitwarden
# and sets the BW_SESSION environment variable if not already set.
bw() {
  bwkey

  bwbin "$@"
}

# run a command but converts environment variables in .env files starting with bw://
# The structure is bw://{ITEM_ID}/{FIELD}
# Where:
#   - `ITEM_ID`: ID
#   - `FIELD`: (optional - default: `password`) Retrieves the value of the field sent, also you can get `username`
# ARGUMENTS:
#   - `--env-file`: (optional - default: `.env`) env file name
bwrun() {
  local envfile=".env"
  local -a env_vars

  # Support for --env-file
  if [[ "$1" == "--env-file" ]]; then
    envfile="$2"
    shift 2
  fi

  [[ ! -f "$envfile" ]] && { echo "❌ Env file '$envfile' not found"; return 1; }

  # Generate key
  bwkey

  # Read file environment
  while IFS='=' read -r key value || [[ -n "$key" ]]; do
    [[ -z "$key" || "$key" == \#* ]] && continue

    # remove optional quotes
    value="${value%\"}"
    value="${value#\"}"

    if [[ "$value" == bw://* ]]; then
      local ref="${value#bw://}"
      local item="${ref%%/*}"
      local field="${ref#*/}"

      local secret=""

      # Get username
      if [[ "$field" == "username" ]]; then
        secret=$(bwbin get username "$item" --session "$BW_SESSION")
      # Get value for selected field
      elif [[ "$field" != "$item" ]]; then
        secret=$(bwbin get item "$item" --session "$BW_SESSION" | jq -r ".fields[]? | select(.name==\"$field\") | .value")
      fi

      # Fallback to find a password if nothing is found
      if [[ -z "$secret" || "$secret" == "null" ]]; then
        secret=$(bwbin get password "$item" --session "$BW_SESSION")
      fi

      env_vars+=("$key=$secret")
    else
      env_vars+=("$key=$value")
    fi
  done < "$envfile"

  # Execute the command with loaded variables
  env "${env_vars[@]}" "$@"
}
