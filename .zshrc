fastfetch --logo blackarch

export EDITOR="nvim"
export PATH=$PATH:/home/proto/.local/bin
export PATH=$PATH:/var/lib/snapd/snap/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/lib/jvm/java-24-openjdk
export PATH=$PATH:/home/proto/.local/share/gem/ruby/3.4.0/bin
export PATH=$PATH:/home/proto/.cargo/bin
export GITHUB_TOKEN=$(<~/.gh_token)
export PATH="$HOME/.npm-global/bin:$PATH"

# export PATH=$PATH:gcc
# export PATH=$PATH:/home/proto/Tools/setoolkit
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export PATH="/opt/lampp/bin:$PATH"

eval "$(oh-my-posh init zsh --config /home/proto/.cache/oh-my-posh/themes/kushal.omp.json)" 
[ -f "$HOME/.zsh_secrets" ] && source "$HOME/.zsh_secrets"

#Setup fzf
eval "$(fzf --zsh)"

#COMPLETION STYLING
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

autoload -Uz compinit
compinit

#Aliases
alias ls="ls --color"
alias cls="clear && printf '\e[3J'"
alias xamppC="sudo /opt/lampp/manager-linux-x64.run"
alias linkdown="sudo ip link set wlp2s0 down";
alias iwman="sudo iw wlp2s0 set type managed";
alias linkup="sudo ip link set wlp2s0 up";
alias sg="$HOME/.local/share/nvim/mason/bin/sg"
# alias setoolkit="/home/proto/Tools/setoolkit/ && sudo ./setoolkit";
alias setoolkit='(cd /home/proto/Tools/setoolkit && sudo ./setoolkit)'

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

#keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

### End of Zinit's installer chunk

# History
HISTSIZE=4000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
