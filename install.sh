#!/data/data/com.termux/files/usr/bin/bash

ZSH_CONF_FILE="${HOME}/.zshrc"
NVIM_CONF_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/init.vim"
TMUX_CONF_FILE="${HOME}/.tmux.conf"
OMT_CONF_FILE="${HOME}/.tmux.conf.local"
TERMUX_CONF_FILE="${HOME}/.termux/termux.properties"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
OMT_HOME="${HOME}/.tmux"

RST=$(tput sgr0)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)

install_zsh() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install zsh and fzf ...${RST}"
    apt install -y zsh fzf
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Make directory ...${RST}"
    mkdir -p "$(dirname $ZINIT_HOME)"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install zinit ...${RST}"
    git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for zsh ...${RST}"
    curl --fail --output ${ZSH_CONF_FILE} --create-dirs https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/zsh.zsh
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Change the login shell to zsh ..."
    chsh -s zsh
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install plugins ...${RST}"
    exec zsh
}

install_neovim() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install neovim, ctags and nodejs ...${RST}"
    apt install -y neovim ctags nodejs
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install vim-plug ...${RST}"
    curl --fail --output "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for Neovim ...${RST}"
    curl --fail --output "${NVIM_CONF_FILE}" --create-dirs https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/neovim.vim
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install plugins ...${RST}"
    nvim +PlugInstall +qa!
}

install_tmux() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install tmux ...${RST}"
    apt install -y tmux
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install oh my tmux ...${RST}"
    git clone https://github.com/gpakosz/.tmux.git ${OMT_HOME}
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Link config file for tmux ...${RST}"
    ln -s -f "${OMT_HOME}/.tmux.conf" "${TMUX_CONF_FILE}"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for oh my tmux ...${RST}"
    curl --fail --output "${OMT_CONF_FILE}" https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/tmux.conf
}

main() {
    install_zsh
    install_neovim
    install_tmux
}

main

