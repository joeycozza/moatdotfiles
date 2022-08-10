export CONFIG_FILES_PATH=$HOME/dotfiles

set -gx PATH $PATH ~/go/bin/

if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $CONFIG_FILES_PATH/aliases
direnv hook fish | source

# Bun
set -Ux BUN_INSTALL "/home/jimmy/.bun"
set -px --path PATH "/home/jimmy/.bun/bin"
setenv EDITOR nvim