set -q FZF_PREVIEW_FILE_CMD; or set -U FZF_PREVIEW_FILE_CMD "head -n 10"
set -q FZF_CTRL_T_COMMAND; or set -U FZF_CTRL_T_COMMAND 'fd --type f --hidden --exclude .git'
set -q FZF_ALT_C_COMMAND; or set -U FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'

fzf_key_bindings
