# Enable profiling if you ever want to debug startup
# zmodload zsh/zprof

# ────────────────────────────────
# 🧠 Fastfetch (run once per session)
[[ -z "$FASTFETCH_SHOWN" ]] && fastfetch && export FASTFETCH_SHOWN=1

# ────────────────────────────────
# 📝 Default Editor
export EDITOR="nvim"

# ────────────────────────────────
# 🔍 FZF configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=always --header --color=always {}'"

# Lazy-load FZF (avoids ~200ms overhead)
if command -v fzf >/dev/null; then
  [[ -n "$PS1" ]] && eval "$(fzf --zsh)"
fi

# ────────────────────────────────
# 🎨 Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Cache completions to speed up reloads
autoload -Uz compinit
compinit -C -d ~/.cache/zsh/zcompdump

# ────────────────────────────────
# 🌳 Aliases
alias tree="tree -L 3 -C -a -I 'git' --charset X"
alias la="eza --all --tree --level 1 --long --color=always --header --icons=always --sort modified --git"

# ────────────────────────────────
# ⚙️ Zinit Plugin Manager
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}Installing Zinit...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ────────────────────────────────
# ⚡ Zinit plugins (Turbo Mode)
zinit ice wait lucid

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Annexes (light mode)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ────────────────────────────────
# ⌨️ Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ────────────────────────────────
# 📜 History
HISTSIZE=4000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ────────────────────────────────
# 🌍 Personal environments & secrets
[ -f "$HOME/.zsh_extra" ] && source "$HOME/.zsh_extra"
[ -f "$HOME/.zsh_secrets" ] && source "$HOME/.zsh_secrets"

# ────────────────────────────────
# 🧩 Lazy Conda Initialization (replaces heavy init)
conda_lazy_init() {
    unset -f conda_lazy_init
    if [ -f "/home/proto/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/proto/miniconda3/etc/profile.d/conda.sh"
        conda activate base
    fi
}
alias conda="conda_lazy_init && conda"

# ────────────────────────────────
# 🔍 Profile summary (for diagnostics)
# zprof
