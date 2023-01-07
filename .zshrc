HISTFILE=~/.zsh-histfile
SAVEHIST=1000
PROMPT="%n@%m[%40<...<%~%<<]# "

setopt APPEND_HISTORY

bindkey "^[[A" up-line-or-search
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char

# Enable the builtin emacs(1) command line editor in sh(1),
# e.g. C-a -> beginning-of-line.
# set -o emacs

# Uncomment this and comment the above to enable the builtin vi(1) command
# line editor in sh(1), e.g. ESC to go into visual mode.
xset -o vi

if [[ -f ~/.zshrc_aliases ]]; then
. ~/.zshrc_aliases
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.zshrc_aliases, instead of adding them here directly.

# some useful aliases
alias h='fc -l'
alias j=jobs
alias m=$PAGER
alias ll='ls -laFo'