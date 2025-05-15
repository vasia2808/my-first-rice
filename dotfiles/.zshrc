source ~/.zsh/prompt/prompt.zsh

source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=(none)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=(none)

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

export LS_COLORS='di=31'

alias vim='nvim'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'

fastfetch
