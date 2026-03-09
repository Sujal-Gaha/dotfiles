# Helpful aliases
alias l 'eza -lh --icons=auto'
alias la 'ls -lAh'
alias ld 'eza -lhD --icons=auto'
alias ll 'eza -lha --icons=auto --sort=name --group-directories-first'
alias ls 'ls --color=tty'
alias lsa 'ls -lah'
alias lt 'eza --icons=auto --tree'
alias c 'clear'                                                        # clear terminal
alias un '$aurhelper -Rns'                                             # uninstall package
alias up '$aurhelper -Syu'                                             # update system/package/aur
alias pl '$aurhelper -Qs'                                              # list installed package
alias pa '$aurhelper -Ss'                                              # list available package
alias pc '$aurhelper -Sc'                                              # remove unused cache
alias po '$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias fastfetch 'fastfetch --logo-type kitty'
alias mkdir 'mkdir -p'


# Directory Aliases
alias .. 'cd ..'
alias ... 'cd ../..'
alias .3 'cd ../../..'
alias .4 'cd ../../../..'
alias .5 'cd ../../../../..'


# Custom Preferences
alias vi 'vim'
# alias vim 'nvim'
alias v "nvim"
alias n "nvim"
alias z "zed ."
