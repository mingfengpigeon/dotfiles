autoload -Uz compinit
compinit

source ${XDG_DATA_HOME:-~/.local/share}/zinit/zinit.git/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh

zinit light Aloxaf/fzf-tab

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

enable-fzf-tab

