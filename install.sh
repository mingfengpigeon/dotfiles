#!/data/data/com.termux/files/usr/bin/bash

ZSH_CONF_FILE="${HOME}/.zshrc"
NVIM_CONF_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/init.vim"
TMUX_CONF_FILE="${HOME}/.tmux.conf"
OMT_CONF_FILE="${HOME}/.tmux.conf.local"
TERMUX_CONF_FILE="${HOME}/.termux/termux.properties"
IPYTHON_CONF_FILE="${HOME}/.ipython/profile_default/ipython_config.py"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
OMT_HOME="${HOME}/.tmux"

RST=$(tput sgr0)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)


configure_zsh() {
    touch "${HOME}.hushlogin"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install ZSH and FZF ...${RST}"
    apt install -y zsh fzf
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Make directory ...${RST}"
    mkdir -p "$(dirname $ZINIT_HOME)"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install Zinit ...${RST}"
    git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for ZSH ...${RST}"
    curl --fo "${ZSH_CONF_FILE}" \
        --create-dirs https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/zsh.zsh
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Change the login shell to ZSH ...${RST}"
    chsh -s zsh
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install plugins ...${RST}"
    exec zsh
}


configure_neovim() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install Neovim, Ctags, Python and Node.js ...${RST}"
    apt install -y neovim ctags python nodejs
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install Pynvim.${RST}"
    pip install pynvim
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Instal Vim-plug ...${RST}"
    curl -fo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
        --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for Neovim ...${RST}"
    curl -fo "${NVIM_CONF_FILE}" --create-dirs https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/neovim.vim
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install plugins ...${RST}"
    nvim +PlugInstall +qa!
}


configure_tmux() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install Tmux and Perl ...${RST}"
    apt install -y tmux perl
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install .tmux ...${RST}"
    git clone https://github.com/gpakosz/.tmux.git ${OMT_HOME}
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Link config file for Tmux ...${RST}"
    ln -s -f "${OMT_HOME}/.tmux.conf" "${TMUX_CONF_FILE}"
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for .tmux ...${RST}"
    curl -fo "${OMT_CONF_FILE}" \
        https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/tmux.conf
}


configure_termux() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file for Termux ...${RST}"
    curl -fo "${TERMUX_CONF_FILE}" \
        https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/termux.properties
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Reload Termux ...${RST}"
    termux-reload-settings
}


configure_ipython() {
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install Python and Wget${RST}"
    apt install -y python wget
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install IPython${RST}"
    pip install ipython
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download IPython Style Gruvbox${RST}"
    wget https://github.com/reillysiemens/ipython-style-gruvbox/releases/download/v1.0.0/ipython_style_gruvbox-1.0.0-py3-none-any.whl
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Install IPython Style Gruvbox${RST}"
    pip install ipython_style_gruvbox-1.0.0-py3-none-any.whl
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download the config file of IPython ...${RST}"
    curl -fo "${IPYTHON_CONF_FILE}" \
        https://raw.githubusercontent.com/mingfengpigeon/dotfiles/main/ipython.py
}


main() {
    clear
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Download Ncurses-utils ...${RST}"
    apt install -y ncurses-utils
    echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Please press Enter to continue.${RST}"
    read
    clear
    while true; do
        operation=$(dialog --backtitle dotfiles --title "Installation guide" \
        --menu "What do you want to configure?" 50 50 20 \
            0 "Configure ZSH" \
            1 "Configure Neovim" \
            2 "Configure Tmux" \
            3 "Configure Termux" \
            4 "Configure IPython" \
            5 Exit \
            3>&1 1>&2 2>&3)
        clear
        case $operation in
        0) configure_zsh ;;
        1) configure_neovim ;;
        2) configure_tmux ;;
        3) configure_termux ;;
        4) configure_ipython ;;
        *)
            echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Bye bye~${RST}"
            exit
            ;;
        esac
        echo "${BLUE}[${GREEN}*${BLUE}] ${CYAN}Please press Enter to continue.${RST}"
        read
    done
}


main

