# Initialization code that may require console input (password prompts, [y/n]
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/bin/env zsh
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})‚Ä¶%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# vim mode
zinit ice depth=1

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    blockf \
    zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit light spaceship-prompt/spaceship-prompt
zinit light jeffreytse/zsh-vi-mode

## theme
zinit light romkatv/powerlevel10k

# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait="0a" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# TAB COMPLETIONS
zinit ice wait="0b" lucid blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# FZF
zinit ice from="gh-r" as="command" bpick="*darwin*"
zinit light junegunn/fzf

# FZF BYNARY AND TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as="command" id-as="junegunn/fzf-tmux" pick="bin/fzf-tmux"
zinit light junegunn/fzf

# RIPGREP
zinit ice from="gh-r" as="program" bpick="*apple*" pick="rg"
zinit light BurntSushi/ripgrep

# NEOVIM
zinit ice from="gh-r" as="program" bpick="*macos*" ver="nightly" pick="bin/nvim"
zinit light neovim/neovim

# FORGIT
zinit ice wait lucid
zinit load wfxr/forgit

# LAZYGIT
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*Darwin*" pick="lazygit" atload="alias lg='lazygit'"
zinit light jesseduffield/lazygit

# LAZYDOCKER
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*Darwin*" pick="lazydocker"
zinit light jesseduffield/lazydocker

# FD
zinit ice as="command" from="gh-r" bpick="*apple*" pick="fd"
zinit light sharkdp/fd

# GH-CLI
zinit ice lucid as="command" from="gh-r" bpick="*macOS*" atclone="./gh completion -s zsh > _gh" atpull="%atclone" mv="**/bin/gh* -> gh" pick="usr/bin/gh"
zinit light cli/cli

# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as="junegunn/fzf_completions" pick="/dev/null"
zinit light junegunn/fzf

# FZF-TAB
zinit ice wait="1" lucid
zinit light Aloxaf/fzf-tab

# EXA
zinit ice wait="2" lucid from="gh-r" as="program" mv="bin/exa* -> exa"
zinit light ogham/exa
zinit ice wait blockf atpull'zinit creinstall -q .'

# DELTA
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*apple*" pick="delta"
zinit light dandavison/delta

# DUST
zinit ice wait="2" lucid from="gh-r" as="program" bpick="*darwin*" pick="dust" atload="alias du=dust"
zinit light bootandy/dust

# BOTTOM
zinit ice wait="2" lucid from="gh-r" as="program" bpick='*apple*' pick="btm"
zinit light ClementTsang/bottom

# DUF
zinit ice lucid wait="0" as="program" from="gh-r" bpick='*Darwin*' pick="duf" atload="alias df=duf"
zinit light muesli/duf

# BAT
zinit ice from="gh-r" as="program" pick="bat" bpick="*apple*" atload="alias cat=bat"
zinit light sharkdp/bat

# BAT-EXTRAS
zinit ice lucid wait="1" as="program" pick="src/batgrep.sh"
zinit ice lucid wait="1" as="program" pick="src/batdiff.sh"
zinit light eth-p/bat-extras

# ZSH MANYDOTS MAGIC
zinit ice depth"1" wait lucid pick"manydots-magic" compile"manydots-magic"
zinit light knu/zsh-manydots-magic

# TREE-SITTER
zinit ice as="program" from="gh-r" mv="tree* -> tree-sitter" pick="tree-sitter"
zinit light tree-sitter/tree-sitter

# PRETTYPING
zinit ice lucid wait="" as="program" pick="prettyping" atload="alias ping=prettyping"
zinit load denilsonsa/prettyping

# GLOW
zinit ice lucid wait"0" as"program" from"gh-r" bpick='*Darwin*' pick"glow"
zinit light charmbracelet/glow

## aliases
alias nq="navi --query"
alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh
alias n=navi
alias vim=lvim
alias t=tmux
alias ping="prettyping"
alias renv="source ~/.zshenv"
alias v=lvim
alias ls=exa
alias cat=bat
alias k=kubectl
alias python="python3.9"
alias top=htop
alias tf=terraform
alias ..="cd .."
alias lg='lazygit'

# git aliases
alias g='git'
alias ggpull='git pull origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
alias glo='git log --online'
alias gst='git status'
alias gup='git fetch && git rebase'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gss='git status -s'
alias ga='git add'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'


zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips


# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}


if [[ ! $(tmux ls) ]] 2> /dev/null; then
  tmux new -s base
fi


#####################
# FZF SETTINGS      #
#####################
export FZF_DEFAULT_OPTS="
--ansi
--layout=default
--info=inline
--height=50%
--multi
--preview-window=right:50%
--preview-window=sharp
--preview-window=cycle
--preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--prompt='Œª -> '
--pointer='|>'
--marker='‚úì'
--bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty 2>&1)' > selected
--bind 'ctrl-v:execute(code {+})'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin/:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


## SSM CONFIGS
function aws-ssm-instance-list {
  output=$(aws ssm describe-instance-information --profile "$AWS_PROFILE" --query "InstanceInformationList[*].{Name:ComputerName,Id:InstanceId,IPAddress:IPAddress}" --output text)
  echo "$output"
}

function aws-list-ec2 {
  aws ec2 describe-instances \
    --profile "$AWS_PROFILE" \
    --filters Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output text
}
