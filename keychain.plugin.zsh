(( $+commands[keychain] )) || return

# Define SHORT_HOST if not defined (%m = host name up to first .)
SHORT_HOST=${SHORT_HOST:-${(%):-%m}}

local args=(--quiet --noask)
local -a identities

local _keychain_env_sh

# start keychain...
keychain add ${args} ${identities} --host $SHORT_HOST

# Get the filename to store/lookup the environment from
_keychain_env_sh="$HOME/.keychain/$SHORT_HOST-sh"

# Source environment settings.
[ -f "$_keychain_env_sh" ] && . "$_keychain_env_sh"
