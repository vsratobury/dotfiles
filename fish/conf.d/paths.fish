# configure path variable
if status is-login
    # Настройка MacPorts
    if not contains fish_user_paths /opt/local/bin
        set -pU fish_user_paths /opt/local/bin /opt/local/sbin
    end

    # Установка директории для поиска программ пользователя
    if not contains fish_user_paths $HOME/tools
        set -pU fish_user_paths $HOME/tools
    end

    # Установка директории для поиска GO программ
    if not contains fish_user_paths $HOME/go/bin
        set -pU fish_user_paths $HOME/go/bin
    end

    # Установка директории для fzf
    if not contains fish_user_paths $HOME/.fzf/bin
        set -pU fish_user_paths $HOME/.fzf/bin
    end

    # Установка директории для python
    if not contains fish_user_paths $HOME/Library/Python/3.9/bin
        set -pU fish_user_paths $HOME/Library/Python/3.9/bin
    end
end

