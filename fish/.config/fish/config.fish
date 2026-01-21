function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

set aurhelper 'yay'

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'

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

    # Directory aliases
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .3 'cd ../../..'
    alias .4 'cd ../../../..'
    alias .5 'cd ../../../../..'

    alias vi 'vim'
    # alias vim 'nvim'
    alias v "nvim"
    alias n "nvim"
    alias z "zed"

end
