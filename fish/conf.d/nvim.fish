if not set -q VIMRUNTIME
    set -Ux VIMRUNTIME /usr/local/share/nvim/runtime
    set -Ux VIMSHARE $HOME/.local/share/nvim
    set -Ux VIMRC $HOME/.config/nvim/init.lua
    set -Ux VISUAL nvim
    set -Ux EDITOR nvim
end
