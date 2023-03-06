(( $+commands[keychain] )) || return

# Define SHORT_HOST if not defined (%m = host name up to first .)
SHORT_HOST=${SHORT_HOST:-${(%):-%m}}

local agents=gpg,ssh
local args=(--quiet --noask)
local -a identities

local _keychain_env_sh
local _keychain_env_sh_gpg

# start keychain...
keychain ${args} --agents ${agents} ${identities} --host $SHORT_HOST

# Get the filenames to store/lookup the environment from
_keychain_env_sh="$HOME/.keychain/$SHORT_HOST-sh"
_keychain_env_sh_gpg="$HOME/.keychain/$SHORT_HOST-sh-gpg"

# Source environment settings.
[ -f "$_keychain_env_sh" ] && . "$_keychain_env_sh"
[ -f "$_keychain_env_sh_gpg" ] && . "$_keychain_env_sh_gpg"
