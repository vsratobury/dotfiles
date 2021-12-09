# configure path variable
if status is-login
    # Настройка MacPorts
    fish_add_path /opt/local/bin
    # Установка директории для поиска программ пользователя
    fish_add_path $HOME/tools
    # Установка директории для поиска GO программ
    fish_add_path $HOME/go/bin
    # Установка директории для python
    fish_add_path $HOME/Library/Python/3.9/bin
end

